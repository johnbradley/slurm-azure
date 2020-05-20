#!/usr/bin/env bash
set -e

# run template to create
source config.sh

cyclecloud import_cluster nfs \
   --config=$CCCONFIG \
   -P "UsePublicNetwork=true" \
   -P "MachineType=$NFS_MACHINE_TYPE" \
   -P "Credentials=$ADMIN_USER" \
   -P "Region=$LOCATION" \
   -P "FilesystemSize=$NFS_FILE_SYSTEM_SIZE_GB"  \
   -P "SubnetId=$RESOURCE_GROUP/cyclecloud-vnet/default" \
   -f nfsconfig/nfs.txt -c nfs

cyclecloud start_cluster nfs \
   --config=$CCCONFIG
