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

### Bootstrapping a Fresh MacOS Install

When a brand new installation of MacOS, it is not ready to use YADM out of the box. Please follow these steps for bootstrap the host initially, then, you can use [`yadm`](https://thelocehiliosan.github.io/yadm/) normally after that.

1. Open the `App Store` and _Sign-in_ using your Apple credentials. This will allow you to install applications from the Mac App Store using [mas-cli](https://github.com/mas-cli/mas) with Homebrew.
1. Install _Command Line Tools for Xcode_. You can download it from the [Apple Developer](https://developer.apple.com/download/more/?=command%20line%20tools) site or using the following command:
    ```sh
    xcode-select --install
    ```
1. Update MacOS including _Command Line Tools for Xcode_:
    ```sh
    softwareupdate --all --install --force
    ```
1. Install a temporary version of [`yadm`](https://thelocehiliosan.github.io/yadm/)
    ```sh
    curl -fLo /tmp/yadm https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x /tmp/yadm 
    ```
1. Run [`yadm`](https://thelocehiliosan.github.io/yadm/) and bootstrap
    ```sh
    /tmp/yadm clone --bootstrap https://github.com/alghanmi/dotfiles.git
    ```

#### MacOS Desktop and Application Settings

[`yadm boostrap`](https://yadm.io/docs/bootstrap) is used to configure all aspects of the environment except the MacOS desktop and applications settings. Starting from [Mathias Bynens](https://mathiasbynens.be/)'s [dotfiles/.macos](https://mths.be/macos) configuration, I created a [`macos-settings`](.config/macos/macos-settings) bootstrap script. This should only be run as needed to avoid unexpected behaviour during the normal bootstrap process.

1. Configure the computer name
    ```sh
    # Choose a hostname
    export _hostname="tardis" 

    sudo scutil --set ComputerName "${_hostname}"
    sudo scutil --set HostName "${_hostname}"
    sudo scutil --set LocalHostName "${_hostname}"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${_hostname}"
    ```
1. Optional Configurations
    ```sh
    # Disable the sound effects on boot
    sudo nvram SystemAudioVolume=" "
    ```
1. Run the configuration script
   ```sh
   ${HOME}/.config/macos/macos-settings
   ```


### Antigen Error in Ubuntu
In recent releases of Ubuntu (seen in 18.04 up to 20.04), the Antigen package is malformed. This will result in Antigen not loading properly. This is reported in [zsh-users/antigen/issues/659](https://github.com/zsh-users/antigen/issues/659). To resolve this issue, you can download the latest version of Antigen manually:

```sh
sudo curl --silent --location --output /usr/share/zsh-antigen/antigen.zsh https://raw.githubusercontent.com/zsh-users/antigen/master/bin/antigen.zsh
```
