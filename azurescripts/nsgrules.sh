#!/bin/bash
source variables.sh
nsgrules=$(az network nsg show -g $rgname -n $netsecgroup)
if [ -z "$nsgrules" ]
then
  az network nsg rule create -g $rgname --nsg-name "$netsecgroup" -n $nsgrule1name --priority $nsgrule1priority \
  --source-address-prefixes '*' --source-port-ranges $nsgrule1sourceportrange \
  --destination-address-prefixes '*' \
  --destination-port-ranges $nsgrule1destportrange --access $nsgrule1accessperm  --protocol $nsgrule1protocol \
  --description "Allow from everywhere on ranges 80 and 443."
else
  echo "Rules exist"
fi
