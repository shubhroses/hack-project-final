## Initial Installation
### Step 1. Install Vagrant and QEMU provider for ARM compatibility

```bash
brew install --cask vagrant
brew install qemu
vagrant plugin install vagrant-qemu
```

### Step 2: Install git, curl, bash-completion, docker, kubectl, and k3s

```bash
# Install git curl bash-completion
sudo apt-get update -y
sudo apt-get install git curl bash-completion

# Install docker
curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin

# Install k3s
curl -sfL https://get.k3s.io | sh
```

## Architecture overview
I have build a devsecops build and deploy pipeline with 4 layers. 
```Host -> Vagrant -> Kubernetes -> Docker -> Flask application```

## Steps to test
Run file run.sh 
```bash
./run.sh
```

This file performs the following actions

1. Ensures that vagrant is up and running.
```vagrant up --provider=qemu ```
2. Pulls the latest changes from github.
```git pull origin main```
3. Builds the docker image.
```docker build -t flask-demo .```
4. Makes the docker image accessable to k3s.
```docker save flask-demo | sudo k3s ctr images import -```
5. It applies the kubernetes deployment yaml.
```kubectl apply -f k8s-deploy.yaml```
6. Restarts the kubernetes deployment and waits for it to finish.
```kubectl rollout restart deployment/flask-demo```

## Application features
1. To test from within the vm
```bash
vagrant ssh -c "curl http://localhost:30007"
vagrant ssh -c "curl http://localhost:30007/ping"
vagrant ssh -c "curl http://localhost:30007/system-info"
vagrant ssh -c "curl http://localhost:30007/home"
```

2. To test from host machine
```bash
curl http://localhost:5001
curl http://localhost:5001/ping
curl http://localhost:5001/system-info
curl http://localhost:5001/home
```

3. Easily scale up the application
```bash
vagrant ssh -c "sudo k3s kubectl scale --replicas=3 deployment/flask-demo"
```

## Steps to debug
1. Verify that the services and pods are correctly running
```bash
vagrant ssh -c "sudo k3s kubectl get services"
# flask-service   NodePort    10.43.210.198   <none>        5000:30007/TCP   78m
vagrant ssh -c "sudo k3s kubectl get pods"
# flask-demo-695685c4bc-9s7qc   1/1     Running   0          27m
```
2. Get logs from kubernetes
```vagrant ssh -c "sudo k3s kubectl logs deployment/flask-demo"```
