#!/bin/bash
/usr/bin/killall -KILL gpicview
/usr/bin/killall -KILL startnode.sh
/usr/bin/killall -KILL startFileBrowser.sh
/usr/bin/killall -KILL startWorkspace.sh
/usr/bin/killall -KILL node
/usr/bin/pkill startnode
/usr/bin/pkill gpicview
/usr/bin/pkill startFileBrowse
/usr/bin/pkill startWorkspace
/usr/bin/pkill node

