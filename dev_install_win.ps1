# Make sure that people cannot just run any Powershell script
Set-ExecutionPolicy AllSigned

# Below can be used to check if Chocolatey is installed. This is not necessary though, as chocolatey will not install if already installed. Leaving the command for informational purposes.
# $chocotest = Test-Path "$env:ProgramData\chocolatey\bin\choco.exe"
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# This check can be used to check if chrome is already installed. Currently not used since it doesn't seem to raise issues if already installed.
# $chromeinstalled = Test-Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe'
# if ($chromeinstalled -eq $false) {
    # install chrome
# } else {
    # chrome is already installed. Do not install again.
# }

# Install programs
choco install vscode docker-desktop postman postgresql -y

# Install PostgreSQL with default password
choco install postgresql --params '/Password:postgres' --params-global -y

# Google Chrome is updated a lot. The installation will pull the newest version of Google's servers which will contain a different version than Chcolatey often. Thus, we ignore the checksum whici is likely to differ from Chocolatey's.
choco install googlechrome --ignore-checksums -y

# TODO: postman agent(?), ngrok, pgadmin4
