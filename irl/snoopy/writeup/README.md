# IRL - Snoopy

> > IRL - medium

> We have gotten ahold of the system log from a laptop they left behind at a coffee shop.
>   We think it might contain useful information, please analyze it carefully.


## Writeup
An IRL challenge based on packet sniffing.
A raspberry pi in the basement hosts a hotspot for the challenge.
It broadcasts the flag as a UDP packet every 10 seconds.


## Author Solution
Open the provided system log file and find the SSID of the hotspot "Mainframe" along with its password "Sup3rS3cur3".

Connect to the hotspot using the provided credentials.

Use a tool such as Wireshark to capture the UDP packets and search using a regular expression such as UiTHack25{[a-zA-Z0-9]+} to extract the flag,
or even simpler just search for the string "UiTHack25".
