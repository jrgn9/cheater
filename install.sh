#! /bin/bash

# Extract the home folder of the user who is logged in (since sudo makes $HOME to root)
USER_HOME=$(getent passwd "$(logname)" | cut -d: -f6)

# Defining repository details
USER="jrgn9"
REPO="cheater"
current_version="v1.0.0"

# Checks if the user runs the install script as sudo
if [ ! -w /usr/local/bin ]
then
    echo "Error: Please run this script with sudo so Cheater can be symlinked to /usr/local/bin"
    exit 1
fi

# Check that the user has curl installed and compare versions
if ! command -v curl &> /dev/null
then
    echo ""
    echo "Curl is not installed. Could not check if $current_version is the latest version"
    read -rp "Do you want to continue anyways? (y/n): " proceed_install
elif ! command -v rsync &> /dev/null
then
    echo "rsync is not installed. It is needed to copy the program files. Please install rsync"
    exit 1
else
    # Fetch latest release tag from GitHub via their api
    latest_release=$(curl -s "https://api.github.com/repos/$USER/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

    # Compare versions
    if [ "$latest_release" != "$current_version" ]
    then
        echo ""
        echo "You are about to install version $current_version, but the latest release is $latest_release. You can find the latest version at https://github.com/$USER/$REPO/releases"
        read -rp "Do you still want to continue? (y/n): " proceed_install
    else
        echo ""
        echo "You are installing the latest version: $current_version"
        proceed_install="y"
    fi
fi

# Check if the user want to proceed. Abort if not
if [ "$proceed_install" != "y" ]
then
    echo "Installation aborted"
    exit 1
fi

# Proceeds to the install process 
if [ -d "$USER_HOME/.cheater" ]
then
    printf "\n.cheater directory already exists. All existing program files will be overwritten. Cheat sheets will not be affected"
    exists="y"
else
    echo ""
    echo "Creating .cheater directory for program files in $USER_HOME"
    mkdir "$USER_HOME/.cheater"
fi

echo ""
echo "Moving program files to $USER_HOME/.cheater"

if [ "$exists" = "y" ]
then
    
    rsync -av --exclude="./cheat_sheets" --exclude=".git" . /"$USER_HOME"/.cheater/
else
    rsync -av --exclude=".git" . /"$USER_HOME"/.cheater/
fi

# Change the ownership from root (because of sudo) to the user
chown -R "$(logname)":"$(logname)" "$USER_HOME/.cheater"

echo ""
echo "Giving cheater the right permissions"
chmod 755 "$USER_HOME/.cheater/program_files/cheat"

echo "Creating a symlink of the program to /usr/local/bin. Older versions of the program will be overwritten"
if [ -L /usr/local/bin/cheat ] || [ -e /usr/local/bin/cheat ]
then
    echo "Deleting old cheater symlink"
    rm /usr/local/bin/cheat
fi

ln -s "$USER_HOME"/.cheater/program_files/cheat /usr/local/bin

echo "Installation complete. Run 'cheat -h' in terminal for help or read the documentation"