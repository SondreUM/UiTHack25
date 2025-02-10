# The little cyborg that could

>> Pwn - hard
>
> TBD

## Preface

### Challenge motivation

The challenge is based upon the very famous China Chopper web shell, discussed in the mandiant report [1].
The challenge is designed to test the participants' ability to identify and exploit a web shell hidden within a seemingly innocent PHP website.
However because of the shear number of ways this web shell can be exploited, we de expect to get pwned.

## Writeup


## Reconnaissance

Initial observation shows a basic PHP website displaying phpinfo():
```
https://uithack-2.td.org.uit.no:9003
```

2. Looking at the source code doesn't reveal anything immediately suspicious, but the presence of phpinfo() suggests we should look for other PHP files.

3. Basic directory enumeration reveals the existence of shell.php:
```bash
$ gobuster dir -u https://uithack-2.td.org.uit.no:9003 -w /usr/share/wordlists/dirb/common.txt -x php
...
/index.html (Status: 200)
/shell.php (Status: 200)
```

## Discovery and Exploitation



### References

[1] <https://www.mandiant.com/sites/default/files/2021-09/rpt-china-chopper.pdf>
[2] <https://www.virustotal.com/gui/file/c4bfc3d39c1d01fa01b2100f1e1c8a58e74a2164fe6fae3c320d23ca3682e058/detection>