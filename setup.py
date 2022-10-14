#!/usr/bin/env python3

import argparse
import os
import platform
import time
import shutil
from pathlib import Path
from distutils.spawn import find_executable
from urllib.request import urlretrieve

PLATFORM = platform.system()
DOTFILE_DIR = Path(__file__).parent
LINKS = {
    "bin": "~/.bin",
    "config/Brewfile": "~/.Brewfile",
    "config/alacritty.yml": "~/.config/alacritty/alacritty.yml",
    "config/bashrc": "~/.bashrc",
    "config/config.fish": "~/.config/fish/config.fish",
    "config/fish_plugins": "~/.config/fish/fish_plugins",
    "config/gitconfig": "~/.gitconfig",
    "config/global_ignore": "~/.global_ignore",
    "config/ideavimrc": "~/.ideavimrc",
    "config/init.lua": {"Darwin": "~/.hammerspoon/init.lua"},
    "config/keybindings.json": "~/.vscode/keybindings.json",
    "config/kitty.conf": "~/.config/kitty/kitty.conf",
    "config/settings.json": "~/.vscode/settings.json",
    "config/tmux.conf": "~/.tmux.conf",
    "config/vimrc": ["~/.vimrc", "~/.config/nvim/init.vim"],
    "config/zshrc": "~/.zshrc",
}
SPOONS = ["Caffeine", "ReloadConfiguration"]

def setup():
    if ARGS.unlink:
        _unlink()

    if ARGS.link:
        _link()

    if ARGS.install:
        _install()

def _symlink_pairs():
    for src, files in LINKS.items():
        src = DOTFILE_DIR / src
        files = files if isinstance(files, list) else [files]
        for file in files:
            if isinstance(file, dict):
                if PLATFORM not in file:
                    continue
                file = file[PLATFORM]
            yield src, Path(file).expanduser()

def _log(msg, header=False, subheader=False, level=0):
    if header:
        msg = f"--- {msg}".upper()
        width = os.get_terminal_size().columns
        print()
        print("-" * width)
        print(msg, "-" * (width - len(msg) - 1))
        print("-" * width)
        print()
    elif subheader:
        print("-", msg)
    else:
        print("  " * level, msg)

def _link():
    _log(f"linking config files", header=True)
    for src, dst in _symlink_pairs():
        _symlink(src, dst)

def _unlink():
    _log(f"removing files", header=True)
    for src, dst in _symlink_pairs():
        _symlink(src, dst, remove=True)


def _symlink(src_file, dst_file, remove=False):
    msg = f"symlinking: {src_file} --> {dst_file}"
    if remove:
        if dst_file.is_symlink() and not dst_file.exists():
            if not ARGS.dry_run:
                dst_file.unlink(missing_ok=True)
            msg += " (BAD LINK, REMOVED!!)"
        elif dst_file.is_symlink() and dst_file.exists():
            if not ARGS.dry_run:
                dst_file.unlink(missing_ok=True)
            msg += " (REMOVED!!)"
        elif dst_file.exists():
            backup = f"{dst_file}.backup-at-{int(time.time())}"
            msg += f" (backup: {src_file} --> {backup})"
            if not ARGS.dry_run:
                shutil.copyfile(src_file, dst_file)
        else:
          msg += " (IGNORE!! no link or file to deal with)"
        _log(msg)
    else:
        if dst_file.exists():
            msg += " (EXISTS!!)"
        else:
            if not ARGS.dry_run:
                dst_file.parent.mkdir(parents=True, exist_ok=True)
                dst_file.symlink_to(src_file.resolve())
        _log(msg)

def _install():
    _log(f"installing stuff", header=True)
    if PLATFORM == "Darwin":
        _install_darwin()

    vim_plug_url = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    plug_dirs = [
        "~/.vim/autoload/plug.vim",
        "~/.local/share/nvim/site/autoload/plug.vim"
    ]
    _log("Installing vim-plug", subheader=True)
    for plug_dir in plug_dirs:
        if Path(plug_dir).expanduser().exists():
            _log(f"{plug_dir} (EXISTS!!)", level=1)
        else:
            if not ARGS.dry_run:
                os.system(f"curl -fLo {plug_dir} --create-dirs {vim_plug_url}")



def _install_darwin():
    _install_homebrew()
    _install_hammerspoon_spoons()

def _install_homebrew():
    _log("Installing Homebrew", subheader=True)
    if find_executable("brew"):
        _log("Hombrew exists, no need to install", level=1)
    else:
        if not ARGS.dry_run:
            script_url = "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
            os.system(f"/bin/bash -c \"$(curl -fsSL {script_url})\"")

    if not ARGS.dry_run:
        _log("Installing Homebrew bundle", level=1)
        os.system("brew bundle install --global --no-upgrade --verbose --no-lock")

def _install_hammerspoon_spoons():
    _log("Installing Hammerspoon spoons", subheader=True)
    base_url = "https://raw.githubusercontent.com/Hammerspoon/Spoons/master/Spoons"
    spoons_path = Path("~/.hammerspoon/Spoons/").expanduser()
    if not ARGS.dry_run:
      spoons_path.mkdir(parents=True, exist_ok=True)
    for spoon in SPOONS:
        msg = f"Spoon {spoon}"
        spoon_dir = f"{spoon}.spoon"
        spoon_zip = f"{spoon_dir}.zip"
        url = f"{base_url}/{spoon_zip}"
        if (spoons_path / spoon_dir).exists():
            msg += " (EXISTS!!)"
        else:
            if not ARGS.dry_run:
                urlretrieve(url, str(spoons_path / spoon_zip))
                shutil.unpack_archive(str(spoons_path / spoon_zip), str(spoons_path), "zip")
                (spoons_path / spoon_zip).unlink()
        _log(msg, level=1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--link", action="store_true")
    parser.add_argument("--unlink", action="store_true")
    parser.add_argument("--install", action="store_true")
    parser.add_argument("--dry-run", action="store_true")

    ARGS = parser.parse_args()

    setup()
