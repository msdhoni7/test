#!/bin/bash
source variables.sh
subnet=$(az network vnet subnet show -g $rgname -n $subnet --vnet-name $vnetname)
if [ -z "$subnet" ]
then
az network vnet subnet create -g $rgname --vnet-name $vnetname -n $subnetname\
                            --address-prefix $subnetaddr --network-security-group $netsecgroup
else
      echo "subnet exists"
fi
