#!/usr/bin/env ruby

require "optparse"
require "fileutils"
require "pathname"

def home(path)
  return Pathname.new("~").expand_path.join(path).to_path
end


class Installer < Struct.new(:dry, :uninstall, :use_fish, :use_nvim, :link)

  DOTFILES = ['vimrc', 'ideavimrc', 'tmux.conf', 'gitconfig', 'global_ignore',
              'settings.json', 'keybindings.json']
  DOTFILES_DIR = '.'
  VSCODE_SETTINGS_DST = home('Library/Application Support/Code/User/settings.json')
  VSCODE_KEYBINDINGS_DST = home('Library/Application Support/Code/User/keybindings.json')
  NVIMRC_DST = home('.config/nvim/init.vim')
  VIMRC_DST = home('.vimrc')
  VIM_PLUG_PATH = home('.vim/autoload/plug.vim')
  NVIM_PLUG_PATH = home('.local/share/nvim/site/autoload/plug.vim')
  FISH_SHELL_CONFIG_DIR = home(".config/fish")
  FISH_SHELL_CONFIG = "config.fish"

  def run()
    if uninstall
      run_uninstall()
    else
      run_install()
    end
  end

  def run_uninstall()
    puts "uninstall"
  end

  def run_install()
    link_dotfiles if link
    install_fish_shell if use_fish
  end


  def link_dotfiles
    DOTFILES.each do |dotfile|
      src = Pathname.new(DOTFILES_DIR).expand_path.join(dotfile).to_path
      dst = case dotfile
      when "vimrc" then use_nvim ? NVIMRC_DST : VIMRC_DST
      when "settings.json" then VSCODE_SETTINGS_DST
      when "keybindings.json" then VSCODE_KEYBINDINGS_DST
      else home(".#{dotfile}")
      end

      backup_path(dst)
      delete_path(dst)
      symlink(src, dst)
    end
  end

  def install_fish_shell
    FileUtils.mkdir_p(FISH_SHELL_CONFIG_DIR)
    dst = Pathname.new(FISH_SHELL_CONFIG_DIR).expand_path.join(FISH_SHELL_CONFIG)
    backup_path(dst)
    symlink(FISH_SHELL_CONFIG, dst)
  end

  # helpers
  # ----------------------------------------------------------------------------

  def backup_path(dotfile)
    pathname = Pathname.new(dotfile).expand_path
    if pathname.exist?
      src = pathname.to_path
      dst = "#{src}.backup"

      log("Backing up #{src} to #{dst}")
      FileUtils.mv(src, dst) unless dry
    end
  end

  def delete_path(dotfile)
    pathname = Pathname.new(dotfile).expand_path
    if pathname.exist?
      path = pathname.to_path

      log("Deleting #{path}")
      FileUtils.rm_r(path) unless dry
    end
  end

  def symlink(src, dst)
    log("Symlinking: #{src} -> #{dst}")
    FileUtils.ln(src, dst) unless dry
  end

  def log(str)
    puts "-- #{str}"
  end

end

installer = Installer.new(false, false, false, false, false)

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
