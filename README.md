# Project: must4rd / k3sadm
## Description
 * __must4rd__: create multi-master (ha) k3s cluster using k3sup
 * __k3sadm__: k3s/k8s admin environment

## must4rd
`must4rd` is a wrapper around k3sup, intending to help setup a k3s cluster with
    arbitrary size of nodes, with a single command.

```
usage: must4rd [-u username] [-m max_masters] [-c context] [-k ssh_key] [-x k3sup_xtra_args] server1 [server2] [server...]
    where username is used for authentication into the servers
    where max_masters is set to 3 by default; further nodes are just workers
    example: must4rd 192.168.64.10 192.168.64.11 192.168.64.12
    example: must4rd -u ubuntu servername1 servername2 servername3
    example: must4rd -u ubuntu -m 1 192.168.64.10 192.168.64.11 192.168.64.12
    example: must4rd -c k3sdev -k ~/.ssh/my_key -x "--merge --ssh-port 2222" 192.168.64.10
```

## k3sadm
`k3sadm` is a docker container designed to be used for creation and administration
of kubernetes clusters. Tools included in this tiny alpine-based container include:
 * must4rd
 * k3sup
 * kubectl
 * kubectx
 * kubens
 * arkade
 * helm 3
