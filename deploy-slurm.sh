#!/usr/bin/env bash
set -e

# run template to create
source config.sh

# get NFS ip address
NFS_PRIVATE_IP=$(cyclecloud --config=$CCCONFIG show_nodes -c nfs --format json | jq -r '.[0].Instance.PrivateIp')
echo "Found NFS private IP $NFS_PRIVATE_IP"

cyclecloud import_cluster slurm \
   --config=$CCCONFIG \
   -P "MasterMachineType=$SLURM_MASTER_MACHINE_TYPE" \
   -P "Credentials=$ADMIN_USER" \
   -P "Region=$LOCATION" \
   -P "SubnetId=$RESOURCE_GROUP/cyclecloud-vnet/default" \
   -P "NFSAddress=$NFS_PRIVATE_IP" \
   -P "NFSType=NFS" \
   -P "HTCMachineType=$SLURM_HTC_MACHINE_TYPE" \
   -P "MaxHPCExecuteCoreCount=$SLURM_HTC_MAX_CORE_COUNT" \
   -P "HPCMachineType=$SLURM_HPC_MACHINE_TYPE" \
   -P "MaxHTCExecuteCoreCount=$SLURM_HPC_MAX_CORE_COUNT" \
   -f slurmconfig/slurm-filers.txt -c Slurm


