#!/usr/bin/env ruby

require "optparse"
require "fileutils"
require "pathname"

def home(path)
  return Pathname.new("~").expand_path.join(path).to_path
end


class Installer < Struct.new(:dry, :uninstall, :use_fish, :use_nvim, :link, :override_links)

  DOTFILES_DIR = File.expand_path(File.dirname(__FILE__))
  DOTFILES = ["vimrc", "ideavimrc", "tmux.conf", "gitconfig", "global_ignore",
              "settings.json", "keybindings.json", "init.lua", "config.fish"]

  def run()
    if uninstall
      run_uninstall()
    else
      run_install()
    end
  end

  def run_uninstall()
    log("Uninstalling .......")
    log("")

    dots = DOTFILES + ["vimrc.local", "fish.local"]
    dots.each do |dotfile|
      delete_path(dotfile_dst(dotfile))
    end
  end

  def run_install()
    log("Installing .......")
    log("")
    link_dotfiles if link
  end


  def link_dotfiles
    DOTFILES.each do |dotfile|
      log(dotfile)
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

  def install_vim_plug
    vim_plug_path = if use_nvim
                      home(".local/share/nvim/site/autoload/plug.vim")
                    else
                      home(".vim/autoload/plug.vim")
                    end
    if File.exist?(vim_plug_path)
      log("vim-plug exists at #{vim_plug_path}", 1)
    else
      log("Installing vim-plug at #{vim_plug_path}", 1)
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
    if dotfile ==  "vimrc"
      install_vim_plug
      FileUtils.touch(home(".vimrc.local"))
    end

    if dotfile ==  "config.fish"
      FileUtils.touch(home(".fish.local"))
    end
  end

  def backup_path(dotfile)
    pathname = Pathname.new(dotfile).expand_path
    if pathname.exist?
      src = pathname.to_path
      dst = "#{src}.backup"

      log("Backing up: #{src} --> #{dst}", 1)
      FileUtils.mv(src, dst) unless dry
    end
  end

  def delete_path(dotfile)
    pathname = Pathname.new(dotfile).expand_path
    if pathname.exist?
      path = pathname.to_path

      log("Deleting: #{path}", 1)
      FileUtils.rm_r(path) unless dry
    end
  end

  def symlink(src, dst)
    log("Symlinking: #{src} --> #{dst}", 1)
    FileUtils.ln(src, dst) unless dry
  end

  def log(str, level = 0)
    spacing  = "    " * level
    puts "- #{spacing}#{str}"
  end

end

installer = Installer.new(false, false, false, false, false, false)

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

  opts.on("-h", "--help", "Print help") do
    puts opts
    exit
  end
end

opt_parser.parse!(ARGV.empty? ? ["-h"] : ARGV)

installer.run()
