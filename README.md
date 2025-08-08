### Step 1. Install Vagrant and QEMU provider for ARM compatibility

```bash
brew install vagrant
brew install qemu

sudo apt-get update -y
sudo apt-get install git curl bash-completion
curl -fsSL https://get.docker.com/ | sh
sudo usermod -aG docker vagrant
```