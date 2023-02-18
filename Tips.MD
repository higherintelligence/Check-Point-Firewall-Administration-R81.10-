# Tips
1. Increase the default font size in putty
    - launch putty
    - under saved sessions, note Default Settings
    - in the tree, under Window find Apperance, and click it
    - under Font settings, click Change
    - set font (a monospace font like Consolas or Courier New) and font size
    - click ok
    - back in the tree, click on Session
    - click on Default Settings
    - click Save
    - this does not modify previously saved sessions
2. Check if the management server is completely up (works for SMS and MDS)
    - `$MDS_FWDIR/scripts/check_cpm_status.sh`
