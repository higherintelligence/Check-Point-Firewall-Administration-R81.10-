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
