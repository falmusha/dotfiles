#!/usr/bin/env ruby

require "fileutils"
require "optparse"
require "pathname"
require "mkmf"

module OS
  def OS.windows?
    (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
  end

  def OS.mac?
   (/darwin/ =~ RUBY_PLATFORM) != nil
  end

  def OS.unix?
    !OS.windows?
  end

  def OS.linux?
    OS.unix? and not OS.mac?
  end

  def OS.jruby?
    RUBY_ENGINE == 'jruby'
  end
end

def home(path)
  return Pathname.new("~").expand_path.join(path).to_path
end

class Installer < Struct.new(:dry, :uninstall, :use_fish, :use_nvim, :link, :override_links, :brew, :asdf)

  DOTFILES_DIR = File.expand_path(File.dirname(__FILE__))
  BREWFILE = File.join(File.expand_path(File.dirname(__FILE__)), "Brewfile")
  MAC_DOTFILES = ["vimrc", "ideavimrc", "tmux.conf", "gitconfig", "global_ignore",
                  "settings.json", "keybindings.json", "init.lua", "config.fish",
                  "alacritty.yml"]
  LINUX_DOTFILES = ["vimrc", "ideavimrc", "tmux.conf", "gitconfig", "global_ignore",
                    "alacritty.yml", "bashrc"]

  def run()
    if uninstall
      run_uninstall()
    else
      run_install()
    end
  end

  def run_uninstall()
    log("Uninstalling .......")
    log("-" * 80)

    get_dotfiles.each do |dotfile|
      delete_path(dotfile_dst(dotfile))
    end

    delete_path(home(".config/nvim/init.vim"))
    delete_path(home(".local/share/nvim/site/autoload/plug.vim"))
    delete_path(home(".vim/autoload/plug.vim"))
  end

  def run_install()
    link_dotfiles() if link
    install_homebrew() if brew and OS.mac?
    install_asdf_plugins() if asdf
  end

  def get_dotfiles()
    if OS.mac?
      MAC_DOTFILES
    else
      LINUX_DOTFILES
    end
  end

  def install_asdf_plugins()
    log("")
    log("asdf plugins", "++ ")
    log("-" * 80)
    system("asdf plugin-add erlang") unless dry
    system("asdf plugin-add elixir") unless dry
    system("asdf plugin-add ruby") unless dry
  end

  def install_homebrew()
    log("")
    log("Homebrew", "++ ")
    log("-" * 80)
    homebrew = find_executable("brew")
    if homebrew.nil?
      install_script = "https://raw.githubusercontent.com/Homebrew/install/master/install"
      system("/usr/bin/ruby -e \"$(curl -fsSL #{install_script})\"") unless dry
    else
      log("Homebrew installed at #{homebrew}", "-- ")
    end
    brew_bundle()
  end

  def brew_bundle()
    log("")
    log("Homebrew packages", "++ ")
    log("-" * 80)
    system("brew bundle install --file #{BREWFILE}") unless dry
  end

  def link_dotfiles()
    log("")
    log("Linking dotfiles", "++ ")
    log("-" * 80)
    get_dotfiles.each do |dotfile|
      log(dotfile, "++ ")
      src = Pathname.new(DOTFILES_DIR).expand_path.join(dotfile).to_path
      dst = dotfile_dst(dotfile)

      should_symlink = !File.exist?(dst) || (File.exist?(dst) && override_links)

      if should_symlink
        pre_link(dotfile)
        symlink(src, dst)
        post_link(dotfile)
      end
    end
  end

  def install_vim_plug()
    vim_plug_path = if use_nvim
                      home(".local/share/nvim/site/autoload/plug.vim")
                    else
                      home(".vim/autoload/plug.vim")
                    end
    if File.exist?(vim_plug_path)
      log("vim-plug exists at #{vim_plug_path}", "-- ")
    else
      log("Installing vim-plug at #{vim_plug_path}", "-- ")
      plug_script = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
      system("curl -fLo #{vim_plug_path} --create-dirs #{plug_script}") unless dry
    end
  end

  # helpers
  # ----------------------------------------------------------------------------

  def dotfile_dst(dotfile)
    case dotfile
    when "vimrc" then use_nvim ? home(".config/nvim/init.vim") : home(".vimrc")
    when "settings.json" then home("Library/Application Support/Code/User/settings.json")
    when "keybindings.json" then home("Library/Application Support/Code/User/keybindings.json")
    when "config.fish" then home(".config/fish/config.fish")
    when "init.lua" then home(".hammerspoon/init.lua")
    when "alacritty.yml" then home(".config/alacritty/alacritty.yml")
    else home(".#{dotfile}")
    end
  end

  def pre_link(dotfile)
    dst = dotfile_dst(dotfile)
    backup_path(dst)
    delete_path(dst)
    FileUtils.mkdir_p(File.dirname(dst)) unless dry
  end

  def post_link(dotfile)
    if dotfile == "vimrc"
      install_vim_plug
      FileUtils.touch(home(".vimrc.local"))
    end

    if dotfile == "config.fish"
      FileUtils.touch(home(".fish.local"))
    end
  end

  def backup_path(dotfile)
    pathname = Pathname.new(dotfile).expand_path
    if pathname.exist?
      src = pathname.to_path
      dst = "#{src}.backup"

      log("Backing up: #{src} --> #{dst}", "-- ")
      if Pathname.new(dst).exist?
        FileUtils.rm(dst) unless dry
      end
      FileUtils.mv(src, dst) unless dry
    end
  end

  def delete_path(dotfile)
    pathname = Pathname.new(dotfile).expand_path
    if pathname.exist?
      path = pathname.to_path

      log("Deleting: #{path}", "-- ")
      FileUtils.rm_r(path) unless dry
    end
  end

  def symlink(src, dst)
    log("Symlinking: #{src} --> #{dst}", "-- ")
    FileUtils.ln(src, dst) unless dry
  end

  def log(str, leading = "")
    puts "#{leading}#{str}"
  end

end

installer = Installer.new(false, false, false, false, false, false, false)

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: install.rb [options]"

  opts.on("-d", "--dry-run", "Dry run, no side effects") do
    installer.dry = true
  end

  opts.on("-f", "--use-fish", "Use fish as the default shell with pure") do
    installer.use_fish = true
  end

  opts.on("-n", "--use-nvim", "Install dotfiles for NeoVim") do
    installer.use_nvim = true
  end

  opts.on("-l", "--link-dotfiles", "Symlink dotfiles") do
    installer.link = true
  end

  opts.on("--override-links", "Backup symlinked dotfiles and replace them") do
    installer.override_links = true
  end

  opts.on("--uninstall", "Uninstall all the Da Dots") do
    installer.uninstall = true
  end

  opts.on("--brew", "Install homebrew and its bundle") do
    installer.brew = true
  end

  opts.on("--asdf", "Install asdf plugins") do
    installer.asdf = true
  end

  opts.on("-h", "--help", "Print help") do
    puts opts
    exit
  end
end

opt_parser.parse!(ARGV.empty? ? ["-h"] : ARGV)

installer.run()
