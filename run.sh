#!/bin/bash
set -eou pipefail

PROJECT_DIR="/home/vagrant/hack-project-final"
GIT_URL="https://github.com/shubhroses/hack-project-final.git"

echo ""
echo "1. Ensure Vagrant is up and running"
vagrant up --provider=qemu

echo ""
echo "2. Git clone or git pull depending on if directory exists"
vagrant ssh -c "
if [ -d ${PROJECT_DIR} ]; then
    echo 'Directory exists'
    cd ${GIT_URL} && git pull origin main
else
    echo 'Directory does not exist'
    git clone ${GIT_URL} ${PROJECT_DIR}
fi
"

echo ""
echo "3. Build docker image and test"
# vagrant ssh -c "cd ${PROJECT_DIR} && docker build flask:demo . && docker run flask:demo -p 5000:5000"
