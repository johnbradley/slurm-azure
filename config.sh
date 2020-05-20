# generic parameters
SUBSCRIPTION="TODO"
# RESOURCE_GROUP must be lowercase since it is used to name other items
RESOURCE_GROUP="TODO"
LOCATION="eastus2"
FUND_CODE=""
ADMIN_USER="TODO"
ADMIN_PUB_KEY="@/Users/TODO/.ssh/id_rsa.pub"

NFS_FILE_SYSTEM_SIZE_GB=120
NFS_MACHINE_TYPE=Standard_DS2_v2

SLURM_MASTER_MACHINE_TYPE=Standard_D12_v2
SLURM_HTC_MACHINE_TYPE=Standard_F2s_v2
SLURM_HTC_MAX_CORE_COUNT=100
SLURM_HPC_MACHINE_TYPE=Standard_F2s_v2
SLURM_HPC_MAX_CORE_COUNT=100


TEMPLATE_FILE=cyclecloudtemplate/template.json
PARAMETERS="@cyclecloudtemplate/parameters.json"
CCCONFIG=cycle/config.json
