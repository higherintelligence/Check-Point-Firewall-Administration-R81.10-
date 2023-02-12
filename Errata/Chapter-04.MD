# Chapter 4

## Creating a Windows Server base VM in the GUI pp. 99-109
1. Different user interface from what is pictured when configuring the VM
    - TODO explain the differences
2. Number of CPU cores and RAM not explained
    - The amount of RAM specified, 2GB is sufficient for a basic Windows server with the following notes:
      - When you later configure the SmartConsole VM, this SHOULD be increased to 4GB minimum
      - When you later configure the ADDCDNS VM, this SHOULD be increased to 4GB minimum
    - The book does not address how many CPU cores to assign for the Windows VMs. You can safely default to 1 core for the servers with the following notes:
      - increase the number of cores to 4 for the SmartConsole VM later
      - increase the number of cores to at least 2 for ADDCDNS later (will use in chapter 11, page 432)
3. Unclear what password to use Administrator p. 106
    - You can choose any password you want for the Administrator account here. You won't need it later.
    - However, to be consistent, use the standard password `CPL@b8110` which will be used later setting  up the servers
## Finalizing the Windows Server base VM installation pp. 112-113
1. The provided code uses two storage driver that are note defiled, "Floppy" and "SATA Controller"
    - TODO intitial testing had the VM mostly working when ignoring this error
    - TODO try adding the commands the script

```
SET PATH=%PATH%;CL\ProgramFiles\Oracle\VirtualBox
SET VM=WINBASE
<MISSING LINE defining Floppy controller>
<MISSING LINE defining SATA controller>
VBoxManage storageattach %VM% --storagectl Floppy --port 0 --device 0 --medium emptydrive
VBoxManage storageattach %VM% --storagectl "SATA Controller" --port 1 --port 0 --device 0 --medium emptydrive
VBoxManage storageattach %VM% --storagectl "SATA Controller" --port 2 --port 0 --device 0 --medium emptydrive
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
