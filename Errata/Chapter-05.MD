# Chapter 5

## Check Point VMs have trouble booting
Working with the author on the optimal settings. Provisioning more and more RAM and vCPUs can actually cause issues.

1. In some cases the Check Point VMs will crash at booting; reset (power cycle) the VM and eventually it will boot
2. Very long delays booting Check Point VMs; if there is disk and CPU activity, try letting it run for 15 minutes more
3. Adding more vCPUs doen't always help; 4 vCPUs seems optimal and more than that increases the error messages
4. Multiple resets maybe be required; allow additional time after the console login prompt appears for system services to start

>>From the author: The lab is designed to run on Windows 10 PC with either Intel or AMD 4 core hyperthreaded CPUs and 32GB of RAM.
>>It is also developed using VirtualBox 6 releases which are still available.
>>If Wilndows 11 and VirtualBox 7 are used on a LabHost PC, there may be cases of suboptimal performance and the lack of stability caused by Hyper-V services. Windows 11 and its updates are known to enable Hyper-V in the background to use it for local sandboxing. Please check status of Hyper-V on your host and disable it.
>>Additionally, with VirtualBox and all VMs powerd-down, check the performance metrics and note current RAM utilization. If your LabHost using more than 4GBs when idle, you may run into overutilization. In such a case, keep CPGW and RightHost VMs powered-down until they are needed in the lab.
>>When testing VPN and remote access, keep the LeftHost powered-down.
>>Updated create_CPBASE_Intel.bat and create_CPBASE_AMD.bat are now present to set correct paravirtualization parameters.
>>VirtualBox 7, according to posts on some forums I've came accross, may have some unresoleved bugs affecting its stability with older Intel CPUs.
>>Do NOT run CPBASE and WINBASE VMs, after clones are created- these should remain powered-down.
>>Do NOT changed vCPU count and RAM assigned by scripts to VMs- those are sufficient for our purposes.
>>DO NOT enable Threat Prevention features in teh lab! these are resource hungry modules that we have not made provisions for.

## First Time Configuration Wizard for gateways pp. 167-172
1. The book is missing three steps between steps 3 and 4
    - Device Information (missing this information may be intentional, as this is later configured on page 186)
  >>From the author: It is intentional, since we are performing these actions later.
        - Host Name: CPCM1
        - Domain Name: mycp.lab
        - Primary DNS Server: 10.20.20.10
    - Date and Time Settings
        - Set the date and time as you do on the SMS on page 159
    - Installation Type
        - Select Security Gateway and/or Security Management and click Next
## First-time configuration using the CLI pp. 172-177
1. Page 174, step 8 has an error in the code and is not entirely clear about the correct values to enter
    - Remember to be in expert mode (see step 4, enter the `expert` command)
    - You must run the command provided in the box to retrieve the correct password hash: `dbget passwd:admin:passwd`
    - When editing the file `CPCM2_FTCW`, put the hash you retrieved in single quotes after `admin_hash`. The box has a typo; there should be no space between the single quotes.
>> From the author: you are correct, admin_hash=' $ contains a space. It should not.
## IPv4 Static Routes pp. 188-191
1. Figure 5.35 shows the default gateway static route before it is configured. Page 167 specifically said not to configure a default gateway. After a section of steps you are NOT supposed to follow, a statement without a step number is made, confusing the user.
    - Follow the instructions "When we click Add Gateway or Edit in this section"; enter the IP address according to Figure 5.37
    - In the IPv4 Static Routes section, click on "Default", then click Edit
    - Click Add Gateway then IP Address
    - IPv4 Address: 200.100.0.254
    - Comments: Default Gateway
    - You should now be able to ping 8.8.8.8 from CPCM1
 >>From the author: You are correct, there should be emphasys on performing this action in the lab.
