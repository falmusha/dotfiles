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

DOTFILES_DIR = File.expand_path(File.dirname(__FILE__))
DOTFILES = {
  "bashrc": "~/.bashrc",
  "config.fish": "~/.config/fish/config.fish",
  "tmux.conf": "~/.tmux.conf",
  "vimrc": ["~/.vimrc", "~/.config/nvim/init.vim"],
  "ideavimrc": "~/.ideavimrc",
  "gitconfig": "~/.gitconfig",
  "global_ignore": "~/.global_ignore",
  "settings.json": {mac: "~/Library/Application Support/Code/User/settings.json"},
  "keybindings.json": {mac: "~/Library/Application Support/Code/User/keybindings.json"},
  "init.lua": {mac: "~/.hammerspoon/init.lua"},
  "alacritty.yml": "~/.config/alacritty/alacritty.yml",
  "kitty.conf": "~/.config/kitty/kitty.conf"
}
BREWFILE = File.expand_path("Brewfile", DOTFILES_DIR)

class Installer < Struct.new(:dry, :uninstall, :use_nvim, :link, :override_links, :brew)
  def run
    if uninstall
      run_uninstall
    else
      run_install
    end
  end

  def run_uninstall
    log "Uninstalling ......."
    log "-" * 80

    get_dotfiles.each do |dotfile|
      delete_path dotfile[1]
    end

    # remove vim-plug
    delete_path File.expand_path("~/.local/share/nvim/site/autoload/plug.vim")
    delete_path File.expand_path("~/.vim/autoload/plug.vim")
  end

  def run_install
    link_dotfiles if link
    install_homebrew if brew and OS.mac?
  end

  def get_dotfiles
    os = OS.mac? ? :mac : :links
    symlinks = []

    DOTFILES.each do |src, dst|
      target = dst.is_a?(Hash) ? dst[os] : dst
      if target.is_a? Array
        target.each { |t| symlinks << [src.to_s, t.to_s] }
      else
        symlinks << [src.to_s, target.to_s]
      end
    end

    symlinks.map do |s|
      [File.expand_path(s[0], DOTFILES_DIR), File.expand_path(s[1])]
    end
  end

  def install_homebrew
    log "Homebrew", "+++ "
    log "-" * 80
    homebrew = find_executable "brew"
    if homebrew.nil?
      install_script = "https://raw.githubusercontent.com/Homebrew/install/master/install"
      system("/usr/bin/ruby -e \"$(curl -fsSL #{install_script})\"") unless dry
    else
      log "Homebrew installed at #{homebrew}", "--- "
    end
    brew_bundle
  end

  def brew_bundle
    log "Homebrew packages", "+++ "
    log "-" * 80
    system("brew bundle install --file #{BREWFILE}") unless dry
  end

  def link_dotfiles
    log "Linking dotfiles", "++ "
    log "-" * 80
    get_dotfiles.each do |dotfile|
      src = dotfile[0]
      dst = dotfile[1]

      should_symlink = !File.exist?(dst) || (File.exist?(dst) && override_links)

      if should_symlink
        pre_link dst
        symlink src, dst
        post_link dst
      end
    end
  end

  def install_vim_plug
    vim_plug_path = if use_nvim
                      File.expand_path "~/.local/share/nvim/site/autoload/plug.vim"
                    else
                      File.expand_path "~/.vim/autoload/plug.vim"
                    end
    if File.exist? vim_plug_path
      log "installing: vim-plug exists at #{vim_plug_path}", "*** "
    else
      log "installing: vim-plug at #{vim_plug_path}", "--- "
      plug_script = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
      system("curl -fLo #{vim_plug_path} --create-dirs #{plug_script}") unless dry
    end
  end

  # helpers
  # ----------------------------------------------------------------------------

  def pre_link(dst)
    backup_path dst
    delete_path dst
    FileUtils.mkdir_p File.dirname(dst) unless dry
  end

  def post_link(dotfile)
    case File.basename dotfile
    when ".vimrc"
      install_vim_plug
      FileUtils.touch File.expand_path("~/.vimrc.local")
    when "config.fish"
      FileUtils.touch File.expand_path("~/.fish.local")
    end
  end

  def backup_path(dst)
    return unless File.exist? dst

    backup = "#{dst}.backup"
    log "backing-up: #{dst} --> #{backup}", "--- "
    if File.exist? backup
      log "backing-up: removing old backup #{backup}", "--- "
      FileUtils.rm backup unless dry
    end
    FileUtils.mv dst, backup unless dry
  end

  def delete_path(dst)
    return unless File.exist? dst

    log "  deleting: #{dst}", "--- "
    FileUtils.rm_r dst unless dry
  end

  def symlink(src, dst)
    log "symlinking: #{src} --> #{dst}", "--- "
    FileUtils.ln_s src, dst unless dry
  end

  def log(str, leading = "")
    puts "#{leading}#{str}"
  end

end

installer = Installer.new(false, false, false, false, false, false)

opt_parser = OptionParser.new do |opts|
  opts.banner = "Usage: install.rb [options]"

  opts.on("-d", "--dry-run", "Dry run, no side effects") do
    installer.dry = true
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

  opts.on("-h", "--help", "Print help") do
    puts opts
    exit
  end
end

opt_parser.parse!(ARGV.empty? ? ["-h"] : ARGV)

installer.run
