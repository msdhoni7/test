#!/bin/bash
#1) Resource Group check
source variables.sh
#Resource Group check
rg=$(az group exists -n $rgname)
if [ "$rg" = "true" ];
then
echo "The required Resource Group exists"
else
echo "Needs to be created"
az group create -l "$location" -n $rgname
fi

#2) Subnet NSG check
nsg=$(az network nsg show -g $rgname -n $netsecgroup)
if [ -z "$nsg" ]
then
az network nsg create -g $rgname -n $netsecgroup
az network nsg rule create -g $rgname --nsg-name "$netsecgroup" -n $nsgrule1name --priority $nsgrule1priority \
--source-address-prefixes '*' --source-port-ranges $nsgrule1sourceportrange \
--destination-address-prefixes '*' \
--destination-port-ranges $nsgrule1destportrange --access $nsgrule1accessperm  --protocol $nsgrule1protocol \
--description "Allow from everywhere on ranges 80 and 443."
else
      echo "NSG exists"
fi

#3) Subnet NSG Rules check
nsgrules=$(az network nsg show -g $rgname -n $netsecgroup)
if [ -z "$nsgrules" ]
then
  az network nsg rule create -g $rgname --nsg-name "$netsecgroup" -n $nsgrule1name --priority $nsgrule1priority \
  --source-address-prefixes '*' --source-port-ranges $nsgrule1sourceportrange \
  --destination-address-prefixes '*' \
  --destination-port-ranges $nsgrule1destportrange --access $nsgrule1accessperm  --protocol $nsgrule1protocol \
  --description "Allow from everywhere on ranges 80 and 443."
else
  echo "80 and 443 already added"
fi

#4) Vnet check
vnet=$(az network vnet show -g $rgname -n $vnetname)
if [ -z "$vnet" ]
then
az network vnet create -g $rgname -n $vnetname --address-prefix $addrprefix
else
      echo "Vnet exists"
fi

#5)Subnet check
subnet=$(az network vnet subnet show -g $rgname -n $subnetname --vnet-name $vnetname)
if [ -z "$subnet" ]
then
az network vnet subnet create -g $rgname --vnet-name $vnetname -n $subnetname\
                            --address-prefix $subnetaddr --network-security-group $netsecgroup
else
  echo "subnet exists"
fi
