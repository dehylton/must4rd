# Project: must4rd / k3sadm
## Description
 * __must4rd__: create multi-master (ha) k3s cluster using k3sup
 * __k3sadm__: docker container: k3s/k8s admin environment
 * __k3sadm-adopt__: obtain kubeconfig for a specific k3os host/cluster
 * __k3sadm-merge__: merge adopted clusters into ~/.kube/config

## must4rd
__must4rd__ is a wrapper around k3sup, intending to help setup a k3s cluster with
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
__k3sadm__ is a docker container designed to be used for creation and administration
of kubernetes clusters. Tools included in this tiny alpine-based container include:

 * k3sadm-adopt
 * k3sadm-merge
 * must4rd
 * k3sup
 * kubectl
 * kubectx
 * kubens
 * arkade
 * helm 3
 * ssh and keychain

### Building and usage examples:
```
docker build -t k3sadm:local .
docker run -it --rm k3sadm:local

docker run -it --rm dhylton/k3sadm
docker run -itd --name k3sadm dhylton/k3sadm
docker run -itd --name k3sadm -v ~/.ssh:/myssh dhylton/k3sadm
docker exec -it k3sadm keychain /myssh/id_rsa
docker exec -it k3sadm bash
```

### Helper tools
#### k3sadm-adopt
Obtain kubeconf for a given cluster. This currently assumes k3os or very similar setup.

```
usage: k3sadm-adopt node [nickname]
examples:
    k3sadm-adopt 10.0.0.96
    k3sadm-adopt 10.0.0.96 cluster1
```

#### k3sadm-merge
Merge all adopted k8s clusters into their own contexts in ~/.kube/config

```
usage: k3sadm-merge
```

### Aliases
 * kc : kubectl
 * kx : kubectx
 * kn : kubens

