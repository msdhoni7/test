#!/bin/bash
source variables.sh
#Resource Group check
rg=$(az group exists -n $rgname)
if [ "$rg" = "true" ];
then
echo "The required Resource Group exits"
else
echo "Needs to be created"
az group create -l "$location" -n $rgname
fi
