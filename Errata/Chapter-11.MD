# Chapter 11

## Configuring DHCP on Windows Server p. 432
1. If the "Server Manager App" does not open automatically, user may feel lost installing DHCP and configuring a DHCP scope. Search the Start menu for Add Rules and Features doesn't return anything useful.
    - Start Server Manager
    - Add roles or features
        - next, next, select ADDDCDNS and click Next
        - check DHCP Server and click Add Features
        - click Next, Next, Next
        - click Install, wait for it to complete, click Close
        - Reboot
    - In Server Manager you will see the new DHCP line
        - Click DHCP, then right-click ADDCDNS and click DHCP Manager
    - Launch DHCP Manager
    - Expand the tree
    - Right-Click "IPv4" and select New Scope
        - Name: Left_Side_DHCP_Hosts
        - Start IP address: 10.10.10.51
        - End IP address: 10.10.10.60
        - Length 24 or subnet mask 255.255.255.0
        - No exclusions or delay
        - Lease duration: the default 8 days is a little long for our lab, try 8 hours
        - Yes, configure DHCP options: router 10.10.10.1, DNS 10.20.20.10, domain mycp.lab
        - No WINS servers
        - Activate the scope, Finish
2. The server ADDCDNS really struggles with 1 vCPU and 2GB RAM. It hard pegs at 100% CPU and is unresponsive.
    - Power it off and set to 2vCPU and 4GB RAM for better performance
## Configuring rules for privileged access pp. 432-433
1. Figure 11.7 shows the object "Router", but the objects created are actually "RouterLeft"and "RouterRight"
## Configuring DMZ access rules p. 436
1. User will need to power om DMZSRV for the first time. While the 1 vCPU maxxed out a lot, it is survivable.
## Configuring rules for access to updatable objects pp. 436-437
1. Importing updatable objects requires Internet access, which is not yet working
    - no firewall push (the first push is on page 444, without much explanation)
    - the action will fail, so the recommendation is to disable this incomplete rule for now
## Configuring the HTTPS Inspection p. 444
1. Importing updatable objects requires Internet access, which is not yet working
    - no firewall push (the first push is at the bottom of this page without much explanation)
    - the action will fail, so the recommendation is to disable this incomplete rule for now
    - those is no log setting in the screen shot or in the instructions, so it is up to the user to decide to enable logging on the rule
2. The first time pushing policy is unceremoniously introduced as "Now is a good time to publish the pending changes and install the policy befor moving on to the next section"
    - recommending pushing policy must more frequently in building a lab, so the user can detect and fix issues early on
    - from the Standard policy you have created click the Install Policy button or click the main hamburger menu and click Install Policy
    - install both Access Controll and Threat Prevention Policies
    - the policy installation should succed and the status icon should turn from red circle with a white X to a green circle with a white check
## Distributing and installing the otubound CA and ICA certificates to the client machines pp. 445-453
1. Minor formatting in second paragraph. The name of the VM is SmartConsole; the object name is SmartConsole_VM.
2. The book instructs the user to browse to the Internet. Internet access is not yet working.
    - cannot reach external sites by IP or DNS name

Internet access per the policy as built. Changing to a standard "*Any*" destination enabled Internet access. Re-enabling the General Internet access rule as illustrated broke Internet access.

Building Lab with firewall default routes and DNS settings, and will try and track down the problem.

Pending review of pages 449-464
