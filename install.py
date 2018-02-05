#!/usr/bin/env python3

import argparse
import os
import re
import shutil
import subprocess

DOTFILES_DIR = os.path.abspath('.')
DOTFILES = ['vimrc', 'ideavimrc', 'zshrc', 'tmux.conf', 'gitconfig',
            'global_ignore', 'settings.json', 'keybindings.json']
HOME = os.environ['HOME']
VSCODE_SETTINGS_DST = os.path.join(
    HOME, 'Library/Application Support/Code/User/settings.json')
VSCODE_KEYBINDINGS_DST = os.path.join(
    HOME, 'Library/Application Support/Code/User/keybindings.json')
NVIMRC_DST = os.path.join(HOME, '.config/nvim/init.vim')
VIMRC_DST = os.path.join(HOME, '.vimrc')
VIM_PLUG_PATH = os.path.join(HOME, '.vim/autoload/plug.vim')
NVIM_PLUG_PATH = os.path.join(HOME, '.local/share/nvim/site/autoload/plug.vim')
OHMYZSH_PATH = os.path.join(HOME, '.oh-my-zsh')
CLONE_OHMYZSH = f'git clone git://github.com/robbyrussell/oh-my-zsh.git {OHMYZSH_PATH}'


def output(out, err=False):
    if not err:
        print(out)


def run(command, dry_run):
    if dry_run:
        output('DRY RUN: %s' % command)
        return 0
    else:
        return subprocess.call(command.split(' '))


def symlink(src, dst, dry_run):
    output('Symlinking: %s -> %s' % (src, dst))
    if not dry_run:
        os.symlink(src, dst)


def install_ohmyzsh(dry_run):
    if os.path.exists(OHMYZSH_PATH):
        output('Cool you already use oh-my-zsh')
    else:
        output('Installing Oh-My-Zsh')
        code = run(CLONE_OHMYZSH, dry_run)
        if code != 0:
            output('Ooops! could not install OH-MY-ZSH', True)

    if 'zsh' in os.environ['SHELL']:
        output('Oh Wow! you also use zsh as the defualt shell')
    else:
        output('Making zsh your default shell')
        code = run('chsh -s /bin/zsh', dry_run)
        if code != 0:
            output('Ooops! could not make zsh your default shell', True)


def install_vim_plug(dry_run, use_nvim):
    if use_nvim:
        plug_path = NVIM_PLUG_PATH
    else:
        plug_path = VIM_PLUG_PATH

    if os.path.exists(plug_path):
        output('Plug.vim vim plugin manager already exists')
    else:
        output('Installing Plug.vim')
        cmd = 'curl -fLo %s --create-dirs ' % plug_path \
            + 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        run(cmd, dry_run)


def backup(dotfile, dry_run):
    if os.path.exists(dotfile):
        backup_sfx = re.findall(r'(\d+)$', dotfile)
        if backup_sfx:
            backup_num = int(backup_sfx[0])
        else:
            backup_num = 0

        dotfile_backup = '%s.backup%d' % (dotfile, backup_num + 1)

        output('Backing up %s to %s' % (dotfile, dotfile_backup))
        if not dry_run:
            shutil.copy2(dotfile, dotfile_backup)


def link_dotfiles(dry_run, use_nvim):
    for dotfile in DOTFILES:
        src = os.path.join(DOTFILES_DIR, dotfile)
        if dotfile == 'vimrc':
            dst = NVIMRC_DST if use_nvim else VIMRC_DST
        elif dotfile == 'settings.json':
            dst = VSCODE_SETTINGS_DST
        elif dotfile == 'keybindings.json':
            dst = VSCODE_KEYBINDINGS_DST
        else:
            dst = os.path.join(HOME, '.%s' % dotfile)

        backup(dst, dry_run)
        delete_file(dst, dry_run)
        symlink(src, dst, dry_run)


def delete_file(path, dry_run):
    output('Deleting file %s' % path)

    if os.path.lexists(path):
        if not dry_run:
            os.remove(path)
    else:
        output('File %s does not exist' % path)


def delete_dir(path, dry_run):
    output('Deleting directory %s' % path)

    if os.path.lexists(path):
        if not dry_run:
            shutil.rmtree(path)
    else:
        output('Directory %s does not exist' % path)


def uninstall(dry_run):
    for dotfile in DOTFILES:
        if dotfile == 'vimrc':
            delete_file(NVIMRC_DST, dry_run)
            delete_file(VIMRC_DST, dry_run)
        else:
            delete_file(os.path.join(HOME, '.%s' % dotfile), dry_run)

    delete_file(NVIM_PLUG_PATH, dry_run)
    delete_file(VIM_PLUG_PATH, dry_run)
    delete_dir(OHMYZSH_PATH, dry_run)
    delete_dir(os.path.join(HOME, '.vim'), dry_run)


def parse_args():
    parser = argparse.ArgumentParser(
        description='Da Dots here, you want some?')
    parser.add_argument('--nope', action='store_true',
                        help='Uninstall all the Da Dots')
    parser.add_argument('--dry', '-d', action='store_true',
                        help='Dry run, no side effects')
    parser.add_argument('--zsh', '-z', action='store_true',
                        help='Use zsh as the default shell with oh-my-zsh')
    parser.add_argument('--nvim', '-n', action='store_true',
                        help='Use Neovim instead of stock Vim')
    parser.add_argument('--link', '-l', action='store_true',
                        help='Just symlink')

    return parser.parse_args()


def main():
    args = parse_args()

    if args.nope:
        uninstall(args.dry)
        return

    # update symlinks
    if args.link:
        link_dotfiles(args.dry, args.nvim)
        return

    # Install oh-my-zhs
    if args.zsh:
        install_ohmyzsh(args.dry)

    # Install Plug.vim pluging manager
    install_vim_plug(args.dry, args.nvim)

    # Create dotfiles symlinks
    link_dotfiles(args.dry, args.nvim)


if __name__ == '__main__':
    main()
