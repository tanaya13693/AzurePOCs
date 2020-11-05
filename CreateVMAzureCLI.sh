#Proviiosning using Azure CLI. With Powershell it is similar.

#Create RG
az group create --name "psdemo-rg" --location "westus"
az group list -o table

#Create Virtual Network and Subnet
az network vnet create --resource-group "psdemo-rg" --name "psdemo-vnet-1" --address-prefix "10.1.0.0/16" --subnet-name "psdemo-subnet-1" --subnet-prefix "10.1.1.0/24"

#Create Public IP
az network public-ip create --resource-group "psdemo-rg" --name "psdemo-win-1-pip-1"

#Network Security Group
az network nsg create --resource-group "psdemo-rg" --name "psdemo-win-nsg-1"

#NIC  - Network Interface
az network nic create --resource-group "psdemo-rg" --name "psdemo-win-1-nic-1" --vnet-name "psdemo-vnet-1" --subnet "psdemo-subnet-1" --network-security-group "psdemo-win-nsg-1" --public-ip-address "psdemo-win-1-pip-1"

#Create VM
az vm create --resource-group "psdemo-rg" --name "psdemo-win-1" --location "westus" --nics "psdemo-win-1-nic-1" --image "win2016datacenter" --admin-username "demoadmin"

#Open port for management
az vm open-port --port "3389" --resource-group "psdemo-rg" --name "psdemo-win-1"
az vm list-ip-addresses --name "psdemo-win-1" --output table
