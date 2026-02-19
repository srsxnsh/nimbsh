#!/bin/bash

set -e

cat << "EOF"

         __                                      _           __         __  
  ____  / /_        ____ ___  __  __      ____  (_)___ ___  / /_  _____/ /_ 
 / __ \/ __ \______/ __ `__ \/ / / /_____/ __ \/ / __ `__ \/ __ \/ ___/ __ \
/ /_/ / / / /_____/ / / / / / /_/ /_____/ / / / / / / / / / /_/ (__  ) / / /
\____/_/ /_/     /_/ /_/ /_/\__, /     /_/ /_/_/_/ /_/ /_/_.___/____/_/ /_/ 
                           /____/                                           

EOF

INSTALL_BRANCH="dev"
INSTALL_DIR="home/$USER/.nimbsh"

if [ -d "$INSTALL_DIR" ]; then
	echo "[ $INSTALL_DIR ] found in the system."
	echo "Checking for updates..."

	cd "$INSTALL_DIR"
	
	echo "Fetching the origin..."
	echo "If this fails, there is something wrong with $INSTALL_DIR : you should delete the directory and rerun this scipt to install nimbsh fresh."

	git fetch origin "$INSTALL_BRANCH"

	LOCAL=$(git rev-parse HEAD)
    	REMOTE=$(git rev-parse origin/$INSTALL_BRANCH)

	if [ "$LOCAL" = "$REMOTE" ]; then
		echo "Everything already up to date :)"
		echo "Exiting..."
		exit 0
	fi

	echo "Update found. Updating nimbsh:"
	echo "Pulling from source (origin/$INSTALL_BRANCH)..."
	git pull origin "$INSTALL_BRANCH"
	echo "Recompiling nimbsh..."
	nim c nimbsh.nim
	echo "Nimbsh updated successfully."
else
	echo "[ $INSTALL_DIR ] not found in the system."
	echo "Installing nimbsh..."
	git clone -b "$INSTALL_BRANCH" https://github.com/srsxnsh/nimbsh "$INSTALL_DIR"
	cd "$INSTALL_DIR"

	echo "Compiling nimbsh..."
	nim c nimbsh.nim

	echo "Creating symlink..."
	sudo ln -sf "$INSTALL_DIR/nimbsh" /usr/bin/nimbsh

	echo ""
	echo "nimbsh installed successfully"
	echo "Run [nimbsh] to enter the shell."
fi

