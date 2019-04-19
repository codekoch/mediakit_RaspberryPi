import pymsgbox
import os
import sys
import pymsgbox.native as pymsgbox
gua=False
rdp=True
guacamole="OFF"
rdpconnect="ON\n     use i.e. windows remote desktop client"
type = int(pymsgbox.prompt(text='Select type:\n1: mediakit -> External Device\n2: External Device -> mediakit',title='Screencast settings', default=1))
if type == 1:
    ptype = 1
    print(ptype)
    while ptype > 0:
        ptype = int(pymsgbox.prompt(text='1: Connection via browser: '+str(guacamole)+'\n\n2: Connection via Remote Desktop: '+str(rdpconnect)+'\n\n0: Exit', title='Screencast settings', default=1))
        if ptype == 1:
	    gua=not gua
        if ptype == 2:
            rdp= not rdp
        if gua:
            os.system('sudo service jetty9 restart')
            os.system('sudo service guacd restart')
            guacamole="ON\n     http://<LAN-IP>:8080 (LAN) or\n     http://1.1.1.1:8080 (WLAN)"
        else:
            os.system('sudo service guacd stop')
            os.system('sudo service jetty9 stop') 
            guacamole="OFF"
        if rdp:
            os.system('sudo service xrdp restart')
            rdpconnect="ON\n     use i.e. windows remote desktop client"
        else:
            os.system('sudo service xrdp stop') 
            rdpconnect="OFF"
    sys.exit()  
elif type == 2:
    ptype = int(pymsgbox.prompt(text='Select type:\n1: Connection via parsec (https://parsecgaming.com)\n2: Connection to server of external device via Browser',title='Screencast settings', default=1))
    if ptype == 1:
        os.system('/usr/bin/parsec app_daemon=1')
        sys.exit()
    elif ptype == 2:
        pymsgbox.alert(text='Connecting to screencast-server. \nRecommended server apps i.e. Screen Cast (Deskshare, Inc) for Android. \nAll ports of casting device will be unblocked!', title='Screencast')
        ip = pymsgbox.prompt(text='Please enter the IP of the casting device', title='Screencast settings', default='1.1.1.2')
        port = pymsgbox.prompt(text='Please enter the Port on which the mirror-service is listening', title='Screencast/-mirroring Settings', default='8888')
        #text = "Trying to open the Screencast on %s:%s.\nPress F11 to exit fullscreen.  " % (ip,port)
        #pymsgbox.confirm(title='Information',text=text)
        os.system('/sbin/unblockInternet.sh %s' % (ip))
        os.system('chromium-browser %s:%s --start-fullscreen &' % (ip,port))
        sys.exit()
