#!/bin/bash
source variables.sh
nsg=$(az network nsg show -g $rgname -n $netsecgroup)
if [ -z "$nsg" ]
then
az network nsg create -g $rgname -n $netsecgroup
else
      echo "NSG exists"
fi
