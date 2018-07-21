#!/usr/bin/env ruby

require "optparse"
require "fileutils"
require "pathname"

def from_home(path)
  return Pathname.new("~").expand_path.join(path).to_path
end


class Installer < Struct.new(:dry, :uninstall, :use_zsh, :use_nvim, :link)

  DOTFILES = ['vimrc', 'ideavimrc', 'zshrc', 'tmux.conf', 'gitconfig',
              'global_ignore', 'settings.json', 'keybindings.json']
  DOTFILES_DIR = '.'
  VSCODE_SETTINGS_DST = from_home('Library/Application Support/Code/User/settings.json')
  VSCODE_KEYBINDINGS_DST = from_home('Library/Application Support/Code/User/keybindings.json')
  NVIMRC_DST = from_home('.config/nvim/init.vim')
  VIMRC_DST = from_home('.vimrc')
  VIM_PLUG_PATH = from_home('.vim/autoload/plug.vim')
  NVIM_PLUG_PATH = from_home('.local/share/nvim/site/autoload/plug.vim')
  ZSH_FUNCTIONS = "/usr/local/share/zsh/site-functions"
  PURE_ZSH_URL = "https://raw.githubusercontent.com/sindresorhus/pure/master/pure.zsh"
  ASYNC_ZSH_URL = "https://raw.githubusercontent.com/sindresorhus/pure/master/async.zsh"


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
    install_pure_zsh if use_zsh
  end


  def link_dotfiles
    DOTFILES.each do |dotfile|
      src = Pathname.new(DOTFILES_DIR).expand_path.join(dotfile).to_path
      dst = case dotfile
      when "vimrc" then use_nvim ? NVIMRC_DST : VIMRC_DST
      when "settings.json" then VSCODE_SETTINGS_DST
      when "keybindings.json" then VSCODE_KEYBINDINGS_DST
      else from_home(".#{dotfile}")
      end

      backup_path(dst)
      delete_path(dst)
      symlink(src, dst)
    end
  end

  def install_pure_zsh()
    if Dir.exist?(ZSH_FUNCTIONS)
      log("Installing pure.zsh and async.zsh to #{ZSH_FUNCTIONS}")
    else
      log("Cannot install pure.zsh and async.zsh. #{ZSH_FUNCTIONS} doesn't exist")
      return
    end

    pure_dst = Pathname.new(ZSH_FUNCTIONS).join("prompt_pure_setup").to_path
    async_dst = Pathname.new(ZSH_FUNCTIONS).join("async").to_path

    if File.exist?(pure_dst)
      log("pure.zsh already installed")
    else
      log("Downloading #{PURE_ZSH_URL} to #{pure_dst}")
      system("curl -o #{pure_dst} #{PURE_ZSH_URL}") unless dry
    end

    if File.exist?(async_dst)
      log("async.zsh already installed")
    else
      log("Downloading #{ASYNC_ZSH_URL} to #{async_dst}")
      system("curl -o  #{async_dst} #{ASYNC_ZSH_URL}") unless dry
    end
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

  opts.on("-z", "--use-zsh", "Use zsh as the default shell with pure") do
    installer.use_zsh = true
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
