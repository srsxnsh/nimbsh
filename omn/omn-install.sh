#!/bin/bash

set -e

INSTALL_BRANCH="main"

echo "Oh-My-Nimbsh : Installing..."

curl -fsSL https://raw.githubusercontent.com/srsxnsh/nimbsh/$INSTALL_BRANCH/omn/omn.sh -o /tmp/omn
sudo mv /tmp/omn /usr/bin/omn
sudo chmod +x /usr/bin/omn

echo "Oh-My-Nimbsh : Install successful!"
echo ""
echo "Run [omn] to install or update nimbsh."
