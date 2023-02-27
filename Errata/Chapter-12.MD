# Chapter 12

## Configuring a remote gateway and creating its policy pp. 467-474
1. Page 467 step 2 has the interfaces mixed up
    - clomevms.bat has eth0 being 172.16.16.0 and eth1 being 200.200.0.0
    - Use the corrected commands below
 >>From the author: I do not think that you are correct- on Page 467, Step 2, the eth0 is configured as 200.200.0.1.
 >>On Page 468, the continuation of the code, defining eth1 as 172.16.16.1. This is alligned with the lab diagram in Figure 3.2 -- Lab Topology and the Figure 3.4 – Hosts, interfaces, IP addresses, and networks. So the code changes suggested below are incorrect.

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
```
2. Page 468 step 3 has the wrong IP address for the router. Instead, the book has the user ping the firewall's own IP address
    - `ping 200.200.0.254`
>>From the author: you are correct- user should attempt to ping 200.200.0.254
3. Page 468 step 7 has the user to leave the Internet connection unconfigured. This is intended.
4. Page 450 step 5 fails >>From author: You likely ment Page 470 step 5
    - Logs show failed communications on CPCXL from CPSMS to CPGW_tmp on tcp ports 18191 and 18211
    >>From the author: there is no need for a dedicated rule- the implied rules are taking care of it. This said, I have made amistake in this sequence. The correct sequence is: On Pge 469 Figure 12.2 – Configuring a new gateway object, DO NOT click on Communication. Instead, click OKs and ignore the warnings about undefined topology and the object with duplicate IP. Publish changes and install the policy. Once it is done, you may double-click the CPGW, click Communication and continue with Step 5 Figure 12.3 – Trust established with CPGW. The logic is as follows: Once CPGW object is created, it is automatically eligible for participation in the Implied rules that handle the Ceck Point control connections.
    - It's best that as part of page 468 step 1 to create a new rule 2 to allow CPSMS to CPGW_tmp for services
        - CPD (tcp/19191)
        - CPD_amon (tcp/18192)
        - FW1 (tcp/256)
        - FW1_ica_push (tcp/18211)
    - Later on page 469 step 1, also remove the temporary rule 2 that was created
5. Page 471 figure 12.5 is incorrect if it was cloned using clonevms.bat from the repo and the configuration fixed (see above) to work
    - eth0 topology is Internal
    - eth1 topology is External
6. Page 472 steps 9 and 10 likewise don't match clonevms.bat from the repo
    - step 9 should be double-click eth1, modify topology, ExternalZone
    - step 10 should be double-click eth0, modify topology, override, network defined by the interface IP and Net Mask, enable Anti-Spoofing
## Star community - To center or through the center to other satellites, to Internet and other VPN targets pp. 479-483
1. Page 480 step 4 states that Internet traffic from RightHost should be working; it does not work
    - Update the APCL_URLF_Parent rule by adding Net_172.16.16.0 to source column, and push LeftSide_S2S policy
>>From the author: Incorrect staement- Page 477 step 1 explicitly list the addition of the NET_172.16.16.0 objects to the Source fields of four rules in LeftSide_S2S policy. On page 478 step2, we are publishing and installing both policies
2. Step 6 is mising publishing and installing.
    - Publish all changes and intall LeftSide_S2S policy
>> From the autor: this is accomplished in step 2.
4. Page 481 last paragraph says to "SSH into CPGW". This is not possible from SmartConsole since page 469 step 1 removes CPGW_tmp and nowhere does it state with what to replace it
>>Incorrect statement- Page 472, step 14 states: "Now, in the Standard policy, add the CPGW object to the Destination field of rule 1 and delete the temporary object, CPGW_Temp, that we created earlier, from Object Explorer. In LeftSite_S2S policy rule one, add "CPGW" to the destination. Publish and install policy to allow SSH to CPGW"
## Changing portals' URLs and renewing a gateway cluster certificate pp.483-486
1. Page 485 step 3 will trigger an 'Are you sure?' warning
    - Click Yes to continue.
## Configuring a gateway or cluster for remote access pp. 489-492
1. Page 491 step 7 provides instructions that leave the setting "MAC address for DHCP allocation" at the default; Figure 12.24 has it set to "Calculated per user name"
    - Leave at the default value "MAC address for DHCP allocation" did not seem to break anything
## Configuring acces control policy rules for remote access pp. 497-499
1. Page 499 step 1 discusses replacing the "Int_Nets" object; this is actually the "Any" object since the parent rule already is limited to Int_Nets
    - Cannot add "RA_Role" to the parent rule (not compatible)
    - Add Net_192.168.254.0 to the parent rule
    - Follow the book's instructions, understanding instead of "Int_Nets" you will see "Any"
 >>From the author: Use of "Any" in sources and destinations is a bad practice- dpending on the lenght of your layer/policy, it may adversely affect the performatnce as well as packet-mode search of the policy.
2. Step 4 says to install the policy; it does not warn the users of the warning message that is displayed
    - "You are about to override the current policy with "LeftSide_RA" for these gateways:" is expected
    - click Install
## Preparing remote client pp. 500-506
1. On page 500, under Preparing Remote client, the second paragraph has the user change DNS to 9.9.9.9 and test accessing websites. This will not work because the site-to-site (S2S) VPN tunnel is still active and the traffic is being backhauled and the CPCXL policy is being applied.
>>From the author: This statement is incorrect- on Page 487 in the paragraph under section title "Configuring a remote access IPSec VPN",  it is explicitly written: "Before we begin working on the remote access IPSec VPN, let’s clear out the Branches VPN community: open the VPN community called Branches, and remove CPCXL from Center Gateways and CPGW from Satellite Gateways. Click OK to close this VPN community. Publish the changes and install both policies, LeftSide_S2S and RightSide."
    - Modify the "Branchees" community, VPN Routing, set to "To center only"
    - Publish changes, and push both policies (LeftSide_RA and RightSide)
