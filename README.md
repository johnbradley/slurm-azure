# slurm-azure
Code to deploy a slurm cluster on Azure

## Setup
Install cyclecloud command line program.
Alternately copy this code code into the cyclecloud vm and run steps 4-8 there.

## Steps
1. edit config.sh
2. deploy-cyclecloud.sh
3. perform manual cyclecloud setup via website displayed by deploy-cyclecloud.sh
4. setup-cli.sh setup login details
5. deploy-nfs.sh
6. deploy-slurm.sh
7. add users to slurm cluster if necessary through website
8. start slurm cluster through website
