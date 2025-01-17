# Chapter 9

## Returning to the Lab p. 354
1. The book has the wrong login information
    - Page 162 had the user create the account `secadmin` with password `CPL@b8110`, but on page 354 says to log in as `admin` and password `CPL@b8110`
    - Log in as `secadmin` / `CPL@b8110` to continue
2. Check Point VMs are extremely slow to load, and may crash or freeze. Reset (power cycle) and try again, may require more that one reboot.
## Creating a gateway cluster pp. 359-375
1. You will need to be patient, this is where the VM environment seems to be slowest during the lab build. I ending up adding more RAM and vCPS to the SmartConsole VM; 6GB / 6vCPU was much better than 4GB / 4vCPU. Be sure to Publish after creating the cluster.
2. Sometimes with the lab cab be a little unstable (losing SmartConsole session during cluster setup for example). If this happens, you will discover that once you initialize Secure Internal Communication (SIC) in a gateway, you can't do it again.
    - When this happens, reset SIC on the gateway
    - `cpconfig`, option 5, Secure Internal communication, confirm twice, enter a passphrase
3. Step 23 on page 373 states the status will change to Green, as shown in Figure 9.30. Status is actually Red at this point.
    - The screenshot shows the gateways with a green/checkmark "OK" status; in reality they will be in an error state until the policy is pushed (much) later on page 444
