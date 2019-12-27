# vagrant-ansible-kubernetes - Run a kubernetes cluster on vagrant
This  repo allows you tu setup and run a full kubernetes cluster on vagrant. By default, it consists of:
 * One master node
 * Two slave nodes
 * Flannel networking
 * Not storage (for now)

As of now, this installs kubernetes v1.17.0

# Setting up the cluster
## Requirements
To run this, you need the following requirements:
 * vagrant
 * virtualbox
 * ansible
 
## Set-up + usage
 To set up the cluster, just type the following command:
```bash
$ vagrant up
```
Vagrant and the ansible playbook will automatically create the `kubeconfig` file on the current directory. To use kubectl you can either run it from your session or from the master node.

### kubectl from the current session
To communicate with the cluster from the current terminal, you need to export the KUBECONFIG file path:
```bash
$ export KUBECONFIG=$(pwd)/kubeconfig
```
Then, you'll be able to run kubectl normally:
```bash
$ kubectl get nodes
NAME            STATUS   ROLES    AGE     VERSION
va-k8s-master   Ready    master   7m20s   v1.17.0
va-k8s-n1       Ready    <none>   5m49s   v1.17.0
va-k8s-n2       Ready    <none>   4m32s   v1.17.0
```

### kubectl from the master node
You can also login to the master node and run kubectl form there:
```bash
$ vagrant ssh va-k8s-master
vagrant@va-k8s-master:~$ kubectl get nodes
NAME            STATUS   ROLES    AGE   VERSION
va-k8s-master   Ready    master   7m20s   v1.17.0
va-k8s-n1       Ready    <none>   5m49s   v1.17.0
va-k8s-n2       Ready    <none>   4m32s   v1.17.0
```

## Teardown
Likewise, to destroy the cluster, run:
```bash
$ vagrant destroy -f
```
