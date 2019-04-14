import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
ip = pymsgbox.prompt(text='Which IP should be unblocked? (i.e. 1.1.1.12 or all)',default='all',title='Unblock Internet')
if ip == 'all' :
        os.system('/sbin/unblockInternet.sh all')
else: 
        os.system('/sbin/unblockInternet.sh %s' % ip)
sys.exit()

