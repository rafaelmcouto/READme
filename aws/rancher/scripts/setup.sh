#!/bin/bash

set -x
echo "#########################################################################################"
echo "#                       Stating Installing Docker                                       #"
echo "#########################################################################################"
curl https://releases.rancher.com/install-docker/20.10.sh | sh
sudo usermod -a -G docker ubuntu

echo "#########################################################################################"
echo "#                       Stating MOUNTING DEVICE                                         #"
echo "#########################################################################################"
mkfs.ext4 /dev/nvme1n1
mkdir -p ${MOUNT_POINT}
echo "/dev/nvme1n1 ${MOUNT_POINT} ext4 defaults 0 0" >> /etc/fstab
mount "${MOUNT_POINT}"

echo "#########################################################################################"
echo "#                       Stating Rancher Server                                          #"
echo "#########################################################################################"

mkdir -p ${MOUNT_POINT}/rancher

sudo docker run -d --name=rancher --restart=unless-stopped \
  -p 80:80 -p 443:443 \
  -v /data/rancher:/var/lib/rancher \
  --privileged \
  rancher/rancher:latest \
  --acme-domain ${DOMAIN}