# Misc - Metro Brutes

> > Misc - *points/solves*
>
> The daily trips on the train downtown has been even more boring than usual after recent changes.
> Especially since reception down there is atrocious.
> Time to switch things up and show the middle finger to those guys.
> Luckily for us there was a guy on the dark web willing to sell us a list of commonly used passwords at Evilcorp subsidiaries.
> 
> Flag will be in the format UiTHack25{*insert password*}
> 
> Files: [dump.pcapng](src/dump.pcapng), [10k-most-common.txt](src/10k-most-common.txt)

## Writeup

By looking at the pcapng file in something like `Wireshark` we can see that it is some form of wifi authentication done towards a network called `Ecorp-metro`.

Now if we are supposed to break into that network then the password would be very nice to have.

One of the more "recent", and popular, methods to break into networks is to use a PMKID attack. 
This also seems viable here considering that we have the entire authentication communication between a device and the network.

Our job as such will be to extract the passphrase hash from the authentication exchange and then use a wordlist to find out what the passphrase is.

The choice of tools here in this writeup is `hcxtools` for handling packets and `hashcat` to find the passphrase.

We convert dump.pcapng to workable hash for `hashcat` using `hcxpcapngtool`.
```
hcxpcapngtool -o hash.txt dump.pcapng
```

Then order `hashcat` to crack it.
```
hashcat -a 3 -w4 -m 22000 hash.txt 10k-most-common.txt -o cracked_pmkid.txt
```

This will use the wordlist to search for the correct passphrase to the access point.
When the passphrase is found you will see it in the terminal in addition to it being put in the `cracked_pmkid.txt`

## Resources
https://www.cyberark.com/resources/threat-research-blog/cracking-wifi-at-scale-with-one-simple-trick