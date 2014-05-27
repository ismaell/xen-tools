#!/bin/sh

IP_ADDR=10.20.0.10
NET_MASK=255.255.255.0
GATEWAY=10.20.0.1
HOSTNAME=test1
DNS1=10.20.0.1

test -d /var/tmp/xen-create-image  || mkdir -p /var/tmp/xen-create-image

> /var/tmp/xen-create-image/networkcentos.tmpl
echo IP_ADDR=10.20.0.10 >>/var/tmp/xen-create-image/networkcentos.tmpl
echo NET_MASK=255.255.255.0 >>/var/tmp/xen-create-image/networkcentos.tmpl
echo GATE_WAY=10.20.0.1 >>/var/tmp/xen-create-image/networkcentos.tmpl
echo HOST_NAME=test1 >>/var/tmp/xen-create-image/networkcentos.tmpl
echo NAME_SERVER1=10.20.0.1  >>/var/tmp/xen-create-image/networkcentos.tmpl
echo NAME_SERVER2=10.20.0.2  >>/var/tmp/xen-create-image/networkcentos.tmpl


xen-create-image  --hostname=$HOSTNAME \
        --image=full \
        --lvm=vg2 \
        --size=10GB --fs=ext3 \
        --swap=2G \
        --disk_device=xvda \
        --role=editor \
        --roledir=/etc/xen-tools/role.d \
        --hooks=1 \
        --pygrub \
        --nodhcp \
        --force \
        --vcpus=2 \
        --memory=512M \
        --bridge=br1 \
        --gateway=$GATEWAY \
        --ip=$IP_ADDR \
        --netmask=$NET_MASK \
        --install-method=rinse \
        --dist=centos-6.5 \
        --mirror=http://mirror.hetzner.de/centos/6.5/os/x86_64 \
        --arch=amd64 \
        --kernel=/bootxen/vmlinuz-xen6.5-install \
        --initrd=/bootxen/initrd-xen6.5-install
