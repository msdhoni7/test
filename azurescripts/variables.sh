#!/bin/bash
rgname=rogerstestweb
location="Canada East"
vnetname=MyVnet
addrprefix=10.200.0.0/16
subnetname=weblayer1
subnetaddr=10.200.3.0/24
netsecgroup=MyNsg
nsgrule1name=MyNsgRule
nsgrule1priority=100
nsgrule1sourceportrange="80 443"
nsgrule1destportrange="80 443"
nsgrule1accessperm=Allow
nsgrule1protocol=Tcp
nsgrule1description="Allow from everywhere on ranges 80 and 443."
