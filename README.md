# pc-setup
NOTE! This repo is publicly available. It should NOT contain any company specific data.

This script is not meant to be distributed or used unless permission is given to do so.

# Settings
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
- PostgreSQL with default password 'postgres'. Includes pgAdmin. Note: This install can take a long time.
- Google Chrome. Installed without checking the checksum. Google Chrome's newest install file is pulled by Chocolatey which might be more up to date than Chocolatey. This results in different checksums.
