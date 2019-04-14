import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
ip = pymsgbox.prompt(text='Which IP should be blocked? (i.e. 1.1.1.12 or all)', title='Block Internet', default='all')
if ip == 'all' :
	os.system('/sbin/blockInternet.sh all')
else: 
	os.system('/sbin/blockInternet.sh %s' % ip)
sys.exit()

