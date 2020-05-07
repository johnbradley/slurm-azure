#!/bin/bash
scripts="https://raw.githubusercontent.com/johnbradley/slurm-azure/initial-code/images/install_conda.sh"
imagesource="Canonical:UbuntuServer:18.04-LTS:18.04.201903060"

az image builder create --image-source $imagesource -n ubuntu-with-conda -g slurm \
    --scripts $scripts --managed-image-destinations ubuntu_18_04_conda=eastus
