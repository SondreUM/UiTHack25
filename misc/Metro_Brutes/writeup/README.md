# Metro Brutes

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

## Challenge inspiration

The exploit this challenge is based on is a real one and is called a PMKID attack, first published on the [hashcat forums](https://hashcat.net/forum/thread-7717.html). It is a way to crack WPA/WPA2 passwords by capturing the authentication handshake between a device and an access point. The new approach suggested by **atom** in the forum post, exploits the new roaming protocols (802.11i/p/q/r) to make it *clientless*. The PMKID is constructed by a PMK, SSID, AP MAC and Client MAC. Since the only unknown value is the PMK, which is a hash derived from only the passphrase and SSID, it can be brute-forced efficiently. I would higly recommend reading the original forum post and the [CyberArk](https://www.cyberark.com/resources/threat-research-blog/cracking-wifi-at-scale-with-one-simple-trick) blog post for a more in-depth explanation.

**Take away lesson from this challenge, use long passwords/passphrases.**\
*SondreUM*

## Writeup

By looking at the pcapng file in something like `Wireshark` we can see that it is some form of wifi authentication done towards a network called `Ecorp-metro`.

Now if we are supposed to break into that network then the password would be very nice to have.

One of the more "recent", and popular, methods to break into networks is to use a PMKID attack.
This also seems viable here considering that we have the entire authentication communication between a device and the network.

Our job as such will be to extract the passphrase hash from the authentication exchange and then use a wordlist to find out what the passphrase is.

The choice of tools here in this writeup is `hcxtools` for handling packets and `hashcat` to find the passphrase.

We convert dump.pcapng to workable hash for `hashcat` using [`hcxpcapngtool`](https://github.com/ZerBea/hcxdumptool).

```sh
hcxpcapngtool -o hash.txt dump.pcapng
```

Next up is cracking/bruteforcing the passphrase. For cracking you would often start with the most "x-common-passwords" list or `rockyou.txt`.\
Then order `hashcat` to crack it with mode 22000, [hashcat documentation](https://hashcat.net/wiki/doku.php?id=cracking_wpawpa2).

```sh
hashcat -a 3 -w4 -m 22000 hash.txt 10k-most-common.txt -o cracked_pmkid.txt
```

This will use the wordlist to search for the correct passphrase to the access point.
When the passphrase is found you will see it in the terminal in addition to it being put in the `cracked_pmkid.txt`

One point worth mentioning is that for larger wordlists it is often worth filtering out invalid password/passphrases.
Since we are working with WPA we know that the minimum size of a valid password is 8 characters.
This means we could have eliminated all shorter passwords shorter than 8 characters for more efficiency.
Due to the relatevly small size of the wordlist given in the challenge this isn't as important here, and we will be fine without doing it.

Looking at the output we see that the passphrase is `highlander` and network SSID is `Ecorp-Metro`.

```sh
0dbdbdabc493227e2946bd5e1526f05a:9e73b1fb7a49:02e31f37f0b6:Ecorp-Metro:highlander

```

## Resources

[1] <https://hashcat.net/forum/thread-7717.html>\
[2] <https://www.cyberark.com/resources/threat-research-blog/cracking-wifi-at-scale-with-one-simple-trick>
[3] <https://github.com/ZerBea/hcxdumptool>
[4] <https://hashcat.net/wiki/doku.php?id=cracking_wpawpa2>
