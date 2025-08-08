## Initial Installation
### Step 1. Install Vagrant and QEMU provider for ARM compatibility

```bash
brew install --cask vagrant
brew install qemu
vagrant plugin install vagrant-qemu
```

### Step 2: Install git, curl, bash-completion, docker, kubectl, and k3s

```bash
sudo apt-get update -y
sudo apt-get install git curl bash-completion

curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
chmod +x kubectl
mv kubectl /usr/local/bin

curl -sfL https://get.k3s.io | sh

sudo docker build -t flask-demo .
```

### Architecture overview
I have build a devsecops build and deploy pipeline with 4 layers. 
Host -> Vagrant -> Kubernetes -> Docker -> Flask application

### Steps to test
## Automated
