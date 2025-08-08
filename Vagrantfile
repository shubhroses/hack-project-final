Vagrant.configure("2") do |config|
    config.vm.box = "perk/ubuntu-2204-arm64"

    config.vm.network "forwarded_port", guest: 5000, host: 5000
    config.vm.network "forwarded_port", guest: 22, host: 2222

    config.vm.provider :qmeu do |q|
        q.cpus = 2
        q.memory = "4096"
    end
end