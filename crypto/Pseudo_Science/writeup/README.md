# Crypto - Pseudo Science

> > Crypto - *points/solves*
>
> We've managed to nab some important file off one of the computers at EvilCorp.
> There's only one small problem, it's encrypted, and we don't know the key.
> On the bright side we do have the key generation script, but it doesn't help much.
> We don't know when exactly it was used this year to create the key.
>
> Files: [flag.txt.gpg](../src/flag.txt.gpg), [gen_key.py](src/gen_key.py)

## Writeup

By looking at the [key generation file](src/gen_key.py) we can see that the seed for the key generation is always time.time() divided by 86 400.
This is the amount of seconds in a day, meaning that the seed only changes daily.
The challenge mentions that the key was created this year which means that we only have around 100 seeds to try.
This is something we can brute force.

All we need to do is generate all the possible keys from seed 20050 to 20150 by putting the given python code into a loop and writing to our filename of choice.

From here on we mainly have 3 choices when it comes to finding the correct one.

### Manual testing
There is 100 passwords that could be the correct one. get to work and test them one by one with `gpg flag.txt.gpg` and pasting in the passwords one by one. Eventually you will find the correct one an receive an un-encrypted `flag.txt` which contains the flag.

### Use gnupg python library
a quick `pip install python-gnupg` will allow us to automate the testing by reading each password in python and testing if it creates the desired file when using the gpg.decrypt() function.

A proposed solution using this method can be found in [solution.py](solution.py). It will print the flag when the correct password is found.

### Use John the Ripper
A bit more complicated, but using john the ripper jumbo we can do a quick `gpg2john flag.txt.gpg > hash` to create a hash file for the password of the file. We can then `john --wordlist=wordlist.txt --rules hash` to have it spit out the password.

```
User@Computer writeup % john --wordlist=wordlist.txt --rules hash
Warning: detected hash type "gpg", but the string is also recognized as "gpg-opencl"
Use the "--format=gpg-opencl" option to force loading these as that type instead
Using default input encoding: UTF-8
Loaded 1 password hash (gpg, OpenPGP / GnuPG Secret Key [32/64])
Cost 1 (s2k-count) is 41943040 for all loaded hashes
Cost 2 (hash algorithm [1:MD5 2:SHA1 3:RIPEMD160 8:SHA256 9:SHA384 10:SHA512 11:SHA224]) is 8 for all loaded hashes
Cost 3 (cipher algorithm [1:IDEA 2:3DES 3:CAST5 4:Blowfish 7:AES128 8:AES192 9:AES256 10:Twofish 11:Camellia128 12:Camellia192 13:Camellia256]) is 9 for all loaded hashes
Press 'q' or Ctrl-C to abort, almost any other key for status
faUps9piGgsqCDuLamQQXNmS (?)
1g 0:00:00:10 DONE (2025-01-31 16:35) 0.09191g/s 11.02p/s 11.02c/s 11.02C/s faUps9piGgsqCDuLamQQXNmS
Use the "--show" option to display all of the cracked passwords reliably
Session completed
```
and we can see that it proposes the password `faUps9piGgsqCDuLamQQXNmS`

proceed to opening the flag file with `gpg flag.txt.gpg` and pasting in `faUps9piGgsqCDuLamQQXNmS` we are given a `flag.txt` that can be opened to reveal the flag `UiTHack25{RNj35u5_D03s_n07_H31P}`

## Resources

Include links to the original challenge, writeups, vulnerabilities, tools, etc. here
