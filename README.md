dotfiles
========

Setup my work station with [mise](https://mise.jdx.dev/).

```sh
brew install mise
git clone <this repo> ~/git/dotfiles && cd ~/git/dotfiles
mise trust -a
mise bootstrap --dry-run --force-dotfiles  # preview everything (without --force-dotfiles,
                                           # the preview stops at the first existing file)
mise bootstrap                             # apply everything
mise bootstrap --force-dotfiles            # apply, replacing existing files with links
```

Variants
--------

| Variant | File             | Applied on                     |
|---------|------------------|--------------------------------|
| basic   | `mise.toml`      | every machine                  |
| work    | `mise.work.toml` | machines with `env = ["work"]` |
| srv     | `mise.srv.toml`  | machines with `env = ["srv"]`  |

Variants add to basic. Pick a machine's variants before bootstrapping
(without this file a machine gets basic only):

```sh
mkdir -p ~/.config/mise
echo 'env = ["work"]' > ~/.config/mise/miserc.toml
```

Anything still in `mise.toml` is installed everywhere, so to make something
work-only, remove it from `mise.toml` and `mise.srv.toml`.

Global tool versions live in `config/mise/config.toml`.
