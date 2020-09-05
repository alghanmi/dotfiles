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

If you get an error like `chsh: /usr/local/bin/zsh: non-standard shell`, this means that you don't have `zsh` (or the instance you are attempting to use) in your `/etc/shells` file. So, make sure you append `/etc/shells` to include it. That can be done by running the following command:

```sh
echo "$(which zsh)" | sudo tee -a /etc/shells
```

### Antigen Error in Ubuntu
In recent releases of Ubuntu (seen in 18.04 up to 20.04), the Antigen package is malformed. This will result in Antigen not loading properly. This is reported in [zsh-users/antigen/issues/659](https://github.com/zsh-users/antigen/issues/659). To resolve this issue, you can download the latest version of Antigen manually:

```sh
sudo curl --silent --location --output /usr/share/zsh-antigen/antigen.zsh https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh
```
