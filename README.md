# Build a Kubernetes HA-cluster using k3s & kube-vip & metal-lb via Ansible

*Based on <https://docs.technotim.live/posts/k3s-etcd-ansible/> and <https://github.com/k3s-io/k3s-ansible*

BIG SHOUTOUT TO [TechnoTim](https://github.com/timothystewart6) who made this possible and inspired me be sure to check him out!

## Instructions/notes

Here: <https://thepcgeek.net/posts/ansible-to-k3s-rancher/>

## K3s Ansible Playbook

Build a k3s Kubernetes cluster using Ansible. The goal is easily install a highly available Kubernetes cluster with Traefik and Rancher on machines running:

- [X] Debian
- [X] Ubuntu
- [X] CentOS

on processor architecture:

- [X] x64
- [X] arm64
- [X] armhf

## System requirements

Deployment environment must have Ansible 2.4.0+
Master and nodes must have passwordless SSH access

## Usage

First create a new directory based on the `sample` directory within the `inventory` directory:

```bash
cp -R inventory/sample inventory/my-cluster
```

Second, edit inventory/my_cluster/hosts.ini to match the system information gathered above. For example:

```bash
[master]
192.16.35.12

[node]
192.16.35.[10:11]

[k3s_cluster:children]
master
node
```

If multiple hosts are in the master group, the playbook will automatically setup k3s in HA mode with etcd.
https://rancher.com/docs/k3s/latest/en/installation/ha-embedded/
This requires at least k3s version 1.19.1

Edit inventory/my_cluster/group_vars/all.yml to match your environment.

You can also make any edits needed to the traefik config or chart values ie:(adding resolvers for TLS certs), those files are under `roles/traefik/templates` keep the file names the same though or the playbook will fail

Start provisioning of the cluster using the following command:

```bash
ansible-playbook site.yml -i inventory/my-cluster/hosts.ini --ask-pass --ask-become-pass
```

After deployment control plane will be accessible via virtual ip-address which is defined in inventory/my-cluster/group_vars/all.yml as apiserver_endpoint

Traefik dashboard will be available on the DNS name you specified in the all.yml variables

Rancher will also be available shortly after the playbook finishes at it's DNS name also specified in the variable file

### A note about node-taints and having masters not run workloads on them

In Tim's version he has encorperated adding the criticaladdonsonly=noexecute taint to his playbook process.  I have decided not to include this in my version because I run only 3 master nodes and they run my stuff on them which is perfectly fine to do. I don't have the need to taint my masters.  If you want to continue using my playbook you can taint your masters after deployment by running a kubectl command or adding the taint to the nodes in rancher.


Remove k3s cluster

```bash
ansible-playbook reset.yml -i inventory/my-cluster/hosts.ini --ask-pass --ask-become-pass
```

## Kubeconfig

To get access to your **Kubernetes** cluster just

```bash
scp debian@master_ip:~/.kube/config ~/.kube/config
```

## kube-vip

See <https://kube-vip.io/control-plane/>

## MetalLB

see <https://metallb.universe.tf/installation/>

## Links

Techno-Tim's video on his playbook this is based on: <https://www.youtube.com/watch?v=CbkEWcUZ7zM>

Kube-vip Control Plane is described -> <https://kube-vip.io/control-plane/>