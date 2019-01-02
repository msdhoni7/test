#!/bin/bash
source variables.sh
#Vnet check
vnet=$(az network vnet show -g $rgname -n $vnetname)
if [ -z "$vnet" ]
then
az network vnet create -g $rgname -n $vnetname --address-prefix $addrprefix \
                      --subnet-name $subnet --subnet-prefix $subnetaddr
else
      echo "Vnet exists"
fi
