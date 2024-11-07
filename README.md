# pc-setup
NOTE! This repo is publicly available. It should NOT contain any company specific data.

This script is not meant to be distributed or used unless permission is given to do so.

# Details
## Windows installer (dev_install_win.ps1)

Run this from a powershell window as administrator with the following command:
```
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/winst-uit-je-woning/pc-setup/refs/heads/main/dev_install_win.ps1'))
```

The following list of programs will be installed:
- Chocolatey (package manager, which is used to install the rest of the programs)
- Visual Studio Code
- Docker Desktop
- Postman
- PostgreSQL (inc. pgAdmin)
- Google Chrome
- WSL2 - Ubuntu distro

<strong>PostgreSQL:</strong> The install of PostgreSQL can be a little problematic. It can take a long time, but besides that: sometimes it does and sometimes it doesn't work. If it doesn't work, it's best to ask for help or to try and install it separately. If installed correctly, a default password is set for the postgres user, namely 'postgres'.

<strong>Google Chrome:</strong> Installed without checking the checksum. Google Chrome's newest install file is pulled by Chocolatey which might be more up to date than Chocolatey. This results in different checksums.

<strong>WSL2 - Ubuntu:</strong> This will be installed last, and will open a new terminal stating: "Installing, this may take a few minutes...". Once this is finished, you will be prompted to fill in a new UNIX username and password. Use something you will remember. I advise to use your first name as the UNIX usernamen and your laptop password as the UNIX password. Once the install has succesfully finished, restart the computer.

<strong>After restart:</strong> Docker will autostart, and you can finish the setup.

## WSL2 Setup
Once WSL2 is installed and the system has been rebooted, follow this part of the guide to finish the WSL2 setup.

### Set default profile to Ubuntu terminal
Open (Windows) terminal by pressing start, typing terminal and pressing enter. Once Terminal is open, press <kbd>Ctrl</kbd>+<kbd>,</kbd> to open the Terminal settings. You will be shown the Startup settings. Change the default profile to Ubuntu (the one with the orange logo, not the one with the penguin) and press save. Open a new terminal window (<kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>T</kbd>). This should open an Ubuntu terminal window.

### Run script to install necessary packages
Download the dev_install_wsl2.sh file to your computer. Navigate to this folder in your Ubuntu terminal. Add permissions to run the file:
```
chmod +x dev_install_wsl2.sh
```
And now run the script:
```
./dev_install_wsl2.sh
```
The following packages will be installed
- zsh
- oh-my-zsh including plugins
- GitHub authentication
