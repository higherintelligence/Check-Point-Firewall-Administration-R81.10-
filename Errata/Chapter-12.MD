# Chapter 12

## Configuring a remote gateway and creating its policy pp. 467-474
1. Page 467 step 2 has the interfaces mixed up
    - clomevms.bat has eth0 being 172.16.16.0 and eth1 being 200.200.0.0
    - Use the corrected commands below

clomevms.bat
```
VBoxManage modifyvm "CPGW" --nic1 intnet
VBoxManage modifyvm "CPGW" --nictype1 82540EM
VBoxManage modifyvm "CPGW" --macaddress1 auto
VBoxManage modifyvm "CPGW" --cableconnected1 on
VBoxManage modifyvm "CPGW" --intnet1 Net_172.16.16.0
VBoxManage modifyvm "CPGW" --nic2 intnet
VBoxManage modifyvm "CPGW" --nictype2 82540EM
VBoxManage modifyvm "CPGW" --macaddress2 auto
VBoxManage modifyvm "CPGW" --cableconnected2 on
VBoxManage modifyvm "CPGW" --intnet2 Net_200.200.0.0
```

Corrected code for pages 467-468
```
set hostname CPGW
set interface eth0 ipv4-address 172.16.16.1 subnet-mast 255.255.255.0
set interface eth0 state on
set interface eth1 ipv4-address 200.200.0.1 subnet-mask 255.255.255.0
set interface eth1 state on
set static-route default nexthop gateway address 200.200.0.254 on
add allowed-client host ipv4-address 10.0.0.20
add allowed-client host ipv4-address 200.100.0.20
delete allowed-client host any-host
set expert-password
``
2. Page 468 step 3 has the wrong IP address for the router. Instead, the book has the user ping the firewall's own IP address
    - `ping 200.200.0.254`
3. Page 450 step 5 fails
    - Logs show failed communications on CPCXL from CPSMS to CPGW_tmp on tcp ports 18191 and 18211
    - It's best that as part of page 468 step 1 to create a new rule 2 to allow CPSMS to CPGW_tmp for services
        - CPD (tcp/19191)
        - CPD_amon (tcp/18192)
        - FW1 (tcp/256)
        - FW1_ica_push (tcp/18211)
