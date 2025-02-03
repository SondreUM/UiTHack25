# Misc - Alternate Facts

> > Misc - *points/solves*
>
> The daily trips on the train downtown has been even more boring than usual after recent changes.
> Especially since reception down there is atrocious.
> Time to switch things up and show the middle finger to those guys.
> 
> Flag will be in the format UiTHack25{*insert password*}
> 
> Files: [dump.pcapng](src/dump.pcapng), [10k-most-common.txt](src/10k-most-common.txt)

## Writeup

convert dump.pcapng to workable hash for hashcat
`hcxpcapngtool -o hash.txt dump.pcapng`

order hashcat to crack it, if 
`hashcat -a 3 -w4 -m 22000 hash.txt 10k-most-common.txt -o cracked_pmkid.txt`

this will use the wordlist to search for the correct passphrase to the access point.
when the passphrase is found you will see it in the terminal in addition to it being put in the `cracked_pmkid.txt`

## Resources
https://www.cyberark.com/resources/threat-research-blog/cracking-wifi-at-scale-with-one-simple-trick