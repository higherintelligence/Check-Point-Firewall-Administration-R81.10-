# Chapter 5

## Check Point VMs have trouble booting
1. In some cases the Check Point VMs will crash at booting; reset (power cycle) the VM and eventually it will boot
2. Very long delays booting Check Point VMs; if there is disk and CPU activity, try letting it run for 15 minutes more
3. Adding more vCPUs doen't always help; 4 vCPUs seems optimal and more than that increases the error messages
4. Multiple resets maybe be required; allow additional time after the console login prompt appears for system services to start
## First-time configuration using the CLI pp. 172-177
1. Page 174, step 8 has an error in the code and is not entirely clear about the correct values to enter
    - Remember to be in expert mode (see step 4, enter the `expert` command)
    - You must run the command provided in the box to retrieve the correct password hash: `dbget passwd:admin:passwd`
    - When editing the file `CPCM2_FTCW`, put the hash you retrieved in single quotes after `admin_hash`. The box has a typo; there should be no space between the single quotes.
