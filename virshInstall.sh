#!/usr/bin/env bash

DISK_FORMAT="qcow2" # Define VM disk image format.. qcow2|img
DISK_PATH="/var/lib/libvirt/images" # Define path where VM disk images are stored
DISK_SIZE="100" # Define disk size in GB
EXTRA_ARGS="console=ttyS0,115200n8 serial"
LOCATION="http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/"
NETWORK_BRIDGE="br0" # virbr0
OS_TYPE="linux" # Define OS type to install... linux|windows
OS_VARIANT="ubuntu16.04" # ubuntu14.04|debian8|centos7.0
PRESEED_FILE="/srv/ftp/preseed.cfg" # Define preseed file for Debian based installs if desired
PRESEED_INSTALL="true" # Define if preseed install is desired
RAM="2048" # Define memory to allocate to VM in MB... 512|1024|2048
VCPUS="2" # Define number of vCPUs to allocate to VM
VMName="kvm1" # Define name of VM to create

# Provision VM with preseed.cfg
if [ "$PRESEED_INSTALL" = false ]; then
virt-install \
--name $VMName \
--ram $RAM \
--disk path=$DISK_PATH/$VMName.$DISK_FORMAT,size=$DISK_SIZE \
--vcpus $VCPUS \
--os-type $OS_TYPE \
--os-variant $OS_VARIANT \
--network bridge=$NETWORK_BRIDGE \
--graphics none \
--console pty,target_type=serial \
--location $LOCATION \
--extra-args "$EXTRA_ARGS"
fi

# Provision VM with preseed.cfg
if [ "$PRESEED_INSTALL" = true ]; then
virt-install \
--name $VMName \
--ram $RAM \
--disk path=$DISK_PATH/$VMName.$DISK_FORMAT,size=$DISK_SIZE \
--vcpus $VCPUS \
--os-type $OS_TYPE \
--os-variant $OS_VARIANT \
--network bridge=$NETWORK_BRIDGE \
--graphics none \
--console pty,target_type=serial \
--location $LOCATION \
--initrd-inject=$PRESEED_FILE \
--noreboot \
--extra-args "$EXTRA_ARGS"
fi
