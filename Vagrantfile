# # vi: set ft=ruby :

IMAGE_NAME = "ubuntu/xenial64"
NUM_NODES = 2

Vagrant.configure("2") do |config|
    config.ssh.insert_key = false

    config.vm.provider "virtualbox" do |v|
        v.memory = 2048
        v.cpus = 2
    end

    config.vm.define "va-k8s-master" do |master|
        master.vm.box = IMAGE_NAME
        master.vm.network :private_network, ip: "192.168.50.10"
        master.vm.hostname = "va-k8s-master"
        master.vm.provision "ansible" do |ansible|
            ansible.playbook = "plays/master-playbook.yml"
            ansible.extra_vars = {
                node_ip: "192.168.50.10",
                pod_network_cidr: "11.0.0.0/16",
                service_cidr: "11.1.0.0/24",
                ansible_python_interpreter: "/usr/bin/python3",
            }
        end
    end

    (1..NUM_NODES).each do |i|
        config.vm.define "va-k8s-n#{i}" do |node|
            node.vm.box = IMAGE_NAME
            node.vm.network :private_network, ip: "192.168.50.#{i + 10}"
            node.vm.hostname = "va-k8s-n#{i}"
            node.vm.provision "ansible" do |ansible|
                ansible.playbook = "plays/node-playbook.yml"
                ansible.become = true
                ansible.extra_vars = {
                    node_ip: "192.168.50.#{i + 10}",
                    ansible_python_interpreter: "/usr/bin/python3",
                }
            end
        end
    end
end

