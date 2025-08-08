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
    cd ${PROJECT_DIR} && git pull origin main
else
    echo 'Directory does not exist'
    git clone ${GIT_URL} ${PROJECT_DIR}
fi
"

echo ""
echo "3. Build docker image"
vagrant ssh -c "cd ${PROJECT_DIR} && docker build -t flask-demo ."

echo ""
echo "4. Make docker image visible to k3s"
vagrant ssh -c "cd ${PROJECT_DIR} && docker save flask-demo | sudo k3s ctr images import -"


echo ""
echo "5. Apply k8s-deploy"
vagrant ssh -c "cd ${PROJECT_DIR} && sudo k3s kubectl apply -f k8s-deploy.yaml"

echo ""
echo "6. Restart k8s pods"
vagrant ssh -c "cd ${PROJECT_DIR} && sudo k3s kubectl rollout restart deployment/flask-demo"

echo ""
echo "7. Wait for rollout to finish"
vagrant ssh -c "cd ${PROJECT_DIR} && sudo k3s kubectl rollout status deployment/flask-demo --timeout 60s"