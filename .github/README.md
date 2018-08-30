# Dotfiles

This is @alghanmi's dotfiles that are managed using [`yadm`](https://thelocehiliosan.github.io/yadm/). To use this repository, simply run:

```bash
# Clone the dotfiles
yadm clone https://github.com/alghanmi/dotfiles.git

# Bootstrap your environment
yadm bootstrap
```

## Hints and Tips

### Enabling ZSH as Default Shell
This configuration uses `zsh` as the default shell. Most likely, your shell is not set to `zsh` by default. To do that, you should run the following command:

```sh
chsh -s $(which zsh)
```

If you get an error like `chsh: /usr/local/bin/zsh: non-standard shell`, this means that you don't have `zsh` (or the instance you are attempting to use) in your `/etc/shells` file. So, make sure you append `/etc/shells` to include it.