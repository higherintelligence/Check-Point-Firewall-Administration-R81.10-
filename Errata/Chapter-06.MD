# Chapter 6

## Configuring Gaia using CLISH pp. 216-218
1. Yes, the step 2 creates access via the account secadmin, which doesn't exist on CPCM1. This is by design.
2. Missing default gateway route
>>From the author: you are correct- this command should be executed on page 217 between steps 4 and 5.
    - `set static-route default nexthop gateway address 200.100.0.254 priority 1 on`
    - You should now be able to ping 8.8.8.8 from CPCM2
