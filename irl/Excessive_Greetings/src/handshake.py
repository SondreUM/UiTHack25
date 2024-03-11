import os
from sys import platform
import time

WAIT_TIME = 10

def win_handshake():
    i = 0
    while(True):
        if i % 2 == 0:
            print("connecting to Piratecove...")
            os.system("netsh wlan connect ssid=Piratecove name=Piratecove interface=Wi-Fi")
        else:
            print("disconnecting from Piratecove...")
            os.system("netsh wlan disconnect interface=Wi-Fi")
        
        i = i + 1 % 2

        time.sleep(WAIT_TIME)

def mac_handshake():
    i = 0
    while(True):
        if i % 2 == 0:
            print("connecting to Piratecove...")
            os.system("networksetup -setairportpower en0 on")
            os.system("networksetup -setairportnetwork en0 Piratecove")
        else:
            print("disconnecting from Piratecove...")
            os.system("networksetup -setairportpower en0 off")

        i = i + 1 % 2

        time.sleep(WAIT_TIME)

def linux_handshake():
    return "not implemented yet"
    i = 0
    while(True):
        if i % 2 == 0:
            print("connecting to Piratecove...")
            os.system("nmcli device wifi connect Piratecove")
        else:
            print("disconnecting from Piratecove...")
            os.system("nmcli device disconnect wlp2s0")

        time.sleep(WAIT_TIME)

if __name__ == '__main__':
    # fetch operating system
    if platform == "linux" or platform == "linux2":
        # linux
        print("detected linux")
        linux_handshake()
    elif platform == "darwin":
        # OS X
        print("detected macOS")
        mac_handshake()
    elif platform == "win32":
        # Windows
        print("detected windows")
        win_handshake()
