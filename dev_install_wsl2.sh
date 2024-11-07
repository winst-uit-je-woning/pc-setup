#!/bin/bash

####################### Initialize variables #######################
DCOLOR="cyan"    # Color for information (default color)
QCOLOR="magenta" # Color for question
SCOLOR="green"   # Color for success message
WCOLOR="yellow"  # Color for warning
ECOLOR="red"     # Color for error

####################### Initialize functions #######################
# Function to echo in a given color. Passing a numeric color does not seem to work, so use the textual option.
function cecho {
    local exp=$1
    local color=$2
    if ! [[ $color =~ '^[0-9]$' ]]; then
        case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white | *) color=7 ;; # white or invalid color
        esac
    fi
    tput setaf $color
    echo $exp
    tput sgr0
}

# Function to parse a response from the user. If a different input is given, nothing will happen.
function ask_confirmation {
    while true; do
        read yn
        case $yn in
        [Yy]*)
            echo 'y'
            break
            ;;
        [Nn]*)
            echo 'n'
            break
            ;;
        *) ;;
        esac
    done
}

####################### Start script #######################
# Update our system
cecho "Updating your system" ${DCOLOR}
sudo apt update && sudo apt upgrade -y

# ####################### ZSH + oh-my-zsh #######################
# Source: https://www.reddit.com/r/zsh/comments/riokz2/unattended_install/ or https://gitlab.com/Aetf/automl/-/blob/master/setup-home.sh?ref_type=heads
# Install zsh
cecho "Installing Zsh"  ${DCOLOR}
sudo apt install zsh -y

# Install oh-my-zsh
cecho "Installing oh-my-zsh"  ${DCOLOR}
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install oh-my-zsh plugins
cecho "Installing oh-my-zsh plugins"  ${DCOLOR}
git -C ~/.oh-my-zsh/custom/plugins clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git
git -C ~/.oh-my-zsh/custom/plugins clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git
# p10k plugin
git -C ~/.oh-my-zsh/custom/themes clone --depth=1 https://github.com/romkatv/powerlevel10k.git

# TODO: install and use chezmoi

# Change default shell. This will prompt for a password and is thus done last.
cecho "Changing default shell. Fill in your password."  ${DCOLOR}
tput bel # This will try to get the user's attention by making a sound.
chsh -s $(which zsh)
zsh # launch zsh

####################### GitHub #######################
# Executed in subshell to be able to easily cancel the process.
(
    cecho "Do you want to set up GitHub? [y/n]" ${QCOLOR}
    response=$(ask_confirmation $response)
    if [[ $response != "y" ]]; then
        cecho "Skipping Github setup" ${WCOLOR}
        exit
    fi

    cecho "Installing GitHub CLI." ${DCOLOR}
    sudo apt install gh -y
    cecho "Using the GitHub CLI, we will now authenticate with your account. Press enter / y on the question below." ${DCOLOR}
    BROWSER="/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe" gh auth login -h github.com -p https -w

    cecho "Do you have a GitHub account? [y/n]" ${QCOLOR}
    response=$(ask_confirmation $response)
    if [[ $response != "y" ]]; then
        cecho "First, create an account: https://github.com/signup. Return here after creating an account." ${DCOLOR}
        cecho "Did you create your account succesfully? [y/n]" ${QCOLOR}
        response=$(ask_confirmation $response)
        if [[ $response != "y" ]]; then
            cecho "Cancelling GitHub setup." ${ECOLOR}
            exit
        fi
    fi

    cecho "To set up Git, please provide me with the following information." ${DCOLOR}
    cecho "What is your GitHub email?" ${QCOLOR}
    read email


    cecho "Go to https://github.com/settings/ssh/new and paste the above key. Give it a recognizable name to identify this machine." ${DCOLOR}
    cecho "Did you paste the key? [y/n]" ${QCOLOR}
    response=$(ask_confirmation $response)
    if [[ $response != "y" ]]; then
        cecho "Cancelling GitHub setup." ${ECOLOR}
        exit
    fi

    cecho "We're now going to test The key. If you get permission denied, something went wrong." ${DCOLOR}
    ssh -T git@github.com

    cecho "Setting up GitHub finished." ${SCOLOR}
)

cecho "Install script finished." ${SCOLOR}