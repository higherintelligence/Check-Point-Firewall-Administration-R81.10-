# Chapter 4

## Creating a Windows Server base VM in the GUI pp. 99-109
1. Different user interface from what is pictured when configuring the VM
    - This is due to changes in the VirtualBox UI
2. Number of CPU cores and RAM not explained
    - The amount of RAM specified, 2GB is sufficient for a basic Windows server with the following notes:
      - When you later configure the SmartConsole VM, this SHOULD be increased to 4GB minimum
      - When you later configure the ADDCDNS VM, this SHOULD be increased to 4GB minimum
    - The book does not address how many CPU cores to assign for the Windows VMs. You can safely default to 1 core for the servers with the following notes:
      - increase the number of cores to 4 for the SmartConsole VM later
      - increase the number of cores to at least 2 for ADDCDNS later (will use in chapter 11, page 432)
3. Figure 4.13 shows an incorrect Folder Path.
    - Folder path: C:\CPBook\LabShare
5. Unclear what password to use Administrator p. 106
    - You can choose any password you want for the Administrator account here. You won't need it later.
    - However, to be consistent, use the standard password `CPL@b8110` which will be used later setting  up the servers
## Windows Server base image scripted
1. When the script is used, fails to boot with Windows Setup message "Windows cannot find the Microsoft License Terms. Make sure the installation source are valid and restart the installation."
    - building usng the UI does not have this problem
    - `create_WINBASE.bat` has an extraneous slash one line 20 for hostpath
Reproducing issue error message:
```
C:\CPBook\LabShare\Scripts>VBoxManage sharedfolder add WINBASE --name "Labshare" --hostpath "C:\CPBook\LabShare\" --automount --auto-mount-point F:
VBoxManage.exe: error: RTPathQueryInfo failed on shared folder path 'C:\CPBook\LabShare" --automount --auto-mount-point F:': VERR_INVALID_NAME
VBoxManage.exe: error: Details: code E_INVALIDARG (0x80070057), component SharedFolderWrap, interface ISharedFolder, callee IUnknown
```
Correct code for `create_WINBASE.bat`:
```
SET PATH=%PATH%;C:\Program Files\Oracle\VirtualBox
SET VM=WINBASE
REN C:\CPBook\LabShare\ISOs_and_OVAs\*SERVER_EVAL_x64FRE*.iso WINBASEEVAL.iso
VBoxManage createhd --filename %VM%.vdi --size 40960
VBoxManage createvm --name %VM% --ostype "Windows2019_64" --register
VBoxManage storagectl %VM% --name "SATA Controller" --add sata --controller IntelAHCI
VBoxManage storageattach %VM% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium %VM%.vdi
VBoxManage storageattach %VM% --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium emptydrive
VBoxManage modifyvm %VM% --ioapic on
VBoxManage modifyvm %VM%  --boot2 disk --boot1 dvd --boot3 none --boot4 none
VBoxManage modifyvm %VM% --memory 2048 --vram 128
VBoxManage modifyvm %VM% --nic1 intnet
VBoxManage modifyvm %VM% --nictype1 82540EM
VBoxManage modifyvm %VM% --macaddress1 auto
VBoxManage modifyvm %VM% --cableconnected1 on
VBoxManage modifyvm %VM% --intnet1 Net_DeadEnd
VBoxManage modifyvm %VM% --graphicscontroller vboxsvga
VBoxManage modifyvm %VM% --usbxhci on
VBoxManage modifyvm %VM% --mouse usbtablet
VBoxManage sharedfolder add %VM% --name "Labshare" --hostpath "C:\CPBook\LabShare" --automount --auto-mount-point F:
VBoxManage modifyvm %VM% --clipboard-mode=bidirectional
VBoxManage modifyvm %VM% --draganddrop=bidirectional
VBoxManage modifyvm %VM% --nested-hw-virt on
VBoxManage modifyvm %VM% --pae off
VBoxManage unattended install %VM% --iso=C:\CPBook\LabShare\ISOs_and_OVAs\WINBASEEVAL.iso --image-index=2 --user=Administrator --password=CPL@b8110 --install-additions
VBoxManage startvm %VM% --type gui
```
## Finalizing the Windows Server base VM installation pp. 112-113
1. Step 2 powershell.exe example works exactly as written. The trailing double quote (") is REQUIRED
2. Step 3 provided code uses two storage driver that are not defined, "Floppy" and "SATA Controller"
    - Initial testing had the VM mostly working when ignoring this error
    - Created a corrected script and works well. Creates the Floppy storage and uses the correct storage name
3. Step also references `eject_and_snapshot_WINBASE.bat`. This script needs to be correct as well.
```
SET PATH=%PATH%;C:\Program Files\Oracle\VirtualBox
SET VM=WINBASE
VBoxManage storagectl %VM% --name "Floppy" --add floppy
VBoxManage storageattach %VM% --storagectl Floppy --port 0 --device 0 --medium emptydrive
VBoxManage storageattach %VM% --storagectl "SATA" --port 1 --device 0 --medium emptydrive
VBoxManage storageattach %VM% --storagectl "SATA" --port 2 --device 0 --medium emptydrive
VBoxManage snapshot %VM% take "Snapshot 1" --description "Do NOT delete!!! This snapshot is used to spawn the linked clones of all Windows components in the lab."
```
## Creating a Check Point base VM pp. 113-123
1. Inconsistent naming of the Check Point base VM causes problems
    - Page 114 instructs to name it `CPBASE` and shows this in the screenshot
    - Page 117 shows a different name `CPBASE1`
    - The official code respository script  `eject_and_snapshot_CPBASE.bat` has a typo, calling it `CPBASE1` with causes the script to fail
2. Number of CPU cores and RAM not explained
     - 2 cores minimum, 4 cores is recommended for CPSMS
     - sk104848 recommends at least 6GB memory for the SMS; 8GB for production
3. Book was written with AMD processors in mind, not Intel processors
    - Page 118 instructs checking `VT-x/AMD-V`, which is not available on systems using Intel CPUs
## Preparing SmartConsole pp. 145-146
1. Typo in step 4; the IP address of CPCM1 should be `10.0.0.2`
