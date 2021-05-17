#!/usr/bin/env bash
set -e
host=k
# tmpdir=$(lxc exec $host -- mktemp -p /tmp/k8s.XXXXXX)
tmpdir=$(mktemp --dry-run -p /tmp/k8s.XXXXXX)
lxc exec $host -- mkdir -p $tmpdir

create_zfs_profile(){
  lxc profile create microk8s
  wget https://raw.githubusercontent.com/ubuntu/microk8s/master/tests/lxc/microk8s-zfs.profile -O microk8s.profile
  cat microk8s.profile | lxc profile edit microk8s
  rm microk8s.profile
}

create_host(){
  lxc launch -p default -p microk8s ubuntu:20.04 $host
}

install_microk8s(){
  lxc file push install-microk8s-on-lxd-host.sh $host/tmp/
  lxc exec $host -- /tmp/install-microk8s-on-lxd-host.sh
}

install_pgo(){
  lxc file push install-pgo.sh $host$tmpdir/
  lxc exec $host -- $tmpdir/install-pgo.sh
}

create_test_container(){
  lxc exec $host -- sh -c "microk8s.kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4"
  # lxc exec $host -- "microk8s.kubectl delete deployment hello-node"
}

check_test_container(){
  # lxc exec $host -- sh -c "microk8s.kubectl get -o wide --no-headers pod -l app=hello-node | awk '{print $6}' | xargs -i curl {}:8080"
  lxc exec $host -- bash -c "microk8s.kubectl get -o wide --no-headers pod -l app=hello-node | awk '{print \$6}' | xargs -i curl {}:8080"
}

# create_zfs_profile
# create_host

# install_microk8s
# create_test_container
# check_test_container
install_pgo

# lxc shell $host
