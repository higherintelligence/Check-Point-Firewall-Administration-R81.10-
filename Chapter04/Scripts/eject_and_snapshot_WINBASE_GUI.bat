SET PATH=%PATH%;C:\Program Files\Oracle\VirtualBox
SET VM=WINBASE
VBoxManage storagectl %VM% --name "Floppy" --add floppy
VBoxManage storageattach %VM% --storagectl Floppy --port 0 --device 0 --medium emptydrive
VBoxManage storageattach %VM% --storagectl "SATA" --port 1 --device 0 --medium emptydrive
VBoxManage storageattach %VM% --storagectl "SATA" --port 2 --device 0 --medium emptydrive
VBoxManage snapshot %VM% take "Snapshot 1" --description "Do NOT delete!!! This snapshot is used to spawn the linked clones of all Windows components in the lab."
