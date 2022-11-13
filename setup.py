#!/usr/bin/env python3

import argparse
import json
import os
import platform
import shutil
import subprocess
import sys
import time
import zipfile
from distutils.spawn import find_executable
from pathlib import Path
from tempfile import NamedTemporaryFile
from urllib.request import urlopen

try:
    import tomllib

    TOML_AVAILABLE = True
except ModuleNotFoundError:
    TOML_AVAILABLE = False

PLATFORM = platform.system()
CONFIGS_TOML = Path(__file__).parent / "config.toml"
CONFIGS_JSON = Path(__file__).parent / "config.json"
CONFIGS = dict()
CONFIGS_DIR = CONFIGS_TOML.parent


def load_config():
    global CONFIGS

    if TOML_AVAILABLE:
        with open(CONFIGS_TOML, "rb") as f:
            CONFIGS = tomllib.load(f)
    else:
        with open(CONFIGS_JSON, "rb") as f:
            CONFIGS = json.load(f)


def setup():
    global CONFIGS, CONFIGS_DIR

    load_config()

    if ARGS.generate_json_config:
        if TOML_AVAILABLE == True:
            with open(CONFIGS_JSON, "w+") as f:
                json.dump(CONFIGS, f)
            sys.exit(0)
        else:
            sys.exit("!!ERROR!! Cannot generate JSON when tomllib is not available")

    CONFIGS_DIR = CONFIGS["configs_dir"]

    if ARGS.remove_files:
        remove_files()

    if ARGS.download_files:
        download_files()

    if ARGS.unlink:
        unlink()

    if ARGS.link:
        link()

    if ARGS.install:
        install()


def symlink_pairs():
    symlinks_map = CONFIGS["symlinks"]
    symlinks = symlinks_map["common"]
    if PLATFORM in symlinks_map:
        symlinks = {**symlinks, **symlinks_map[PLATFORM]}

    for config_dir, filenames in symlinks.items():
        config_path = CONFIGS_DIR / Path(config_dir)
        if isinstance(filenames, dict):
            for source, destination in filenames.items():
                src = config_path / source
                dst = Path(os.path.expandvars(destination))
                yield src, dst
        elif isinstance(filenames, str):
            src = config_path
            dst = Path(os.path.expandvars(filenames))
            yield src, dst


def log(msg, header=False, subheader=False, level=0):
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


def link():
    log(f"linking config files", header=True)
    for src, dst in symlink_pairs():
        symlink(src, dst)


def unlink():
    log(f"removing files", header=True)
    for src, dst in symlink_pairs():
        symlink(src, dst, remove=True)


def symlink(src_file, dst_file, remove=False):
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
        log(msg)
    else:
        if dst_file.exists():
            msg += " (EXISTS!!)"
        else:
            if not ARGS.dry_run:
                dst_file.parent.mkdir(parents=True, exist_ok=True)
                dst_file.symlink_to(src_file.resolve())
        log(msg)


def remove_files():
    for download in CONFIGS["downloads"]:
        url = download["url"]
        directory = Path(os.path.expandvars(download["directory"]))
        name = download["name"]
        target = directory / name
        if target.exists():
            log(f"Removing downloaded target {target}")
            if target.is_dir():
                if not ARGS.dry_run:
                    shutil.rmtree(target)
            else:
                if not ARGS.dry_run:
                    target.unlink()


def download_files():
    for download in CONFIGS["downloads"]:
        url = download["url"]
        directory = Path(os.path.expandvars(download["directory"]))
        directory.parent.mkdir(parents=True, exist_ok=True)
        name = download["name"]
        log(f"Downloading {url}")
        if ARGS.dry_run:
            continue

        with urlopen(url) as response, NamedTemporaryFile(
            suffix=".zip", delete=False
        ) as tmp_fp:
            shutil.copyfileobj(response, tmp_fp)

        if download["unzip"]:
            log(f"Unzipping {tmp_fp.name} in {directory}")
            with zipfile.ZipFile(tmp_fp.name) as zip_fp:
                zip_fp.extractall(directory)
        else:
            src = Path(tmp_fp.name).rename(name)
            log(f"Moving {src} to {directory}")
            shutil.move(src, directory)


def install():
    log(f"installing stuff", header=True)
    if PLATFORM == "Darwin":
        install_homebrew()


def install_homebrew():
    log("Installing Homebrew", subheader=True)
    if find_executable("brew"):
        log("Hombrew exists, no need to install", level=1)
    else:
        if not ARGS.dry_run:
            script_url = CONFIGS["urls"]["homebrew_install"]
            install_run = subprocess.run(
                [
                    "/bin/bash",
                    "-c",
                    f"$(curl -fsSL {script_url})",
                ]
            )

    if not ARGS.dry_run:
        log("Installing Homebrew bundle", level=1)
        subprocess.run(
            [
                "brew",
                "bundle",
                "install",
                "--global",
                "--no-upgrade",
                "--verbose",
                "--no-lock",
            ]
        )


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--link", action="store_true")
    parser.add_argument("--unlink", action="store_true")
    parser.add_argument("--download-files", action="store_true")
    parser.add_argument("--remove-files", action="store_true")
    parser.add_argument("--install", action="store_true")
    parser.add_argument("--dry-run", action="store_true")
    parser.add_argument("--generate-json-config", action="store_true")

    ARGS = parser.parse_args()

    setup()
