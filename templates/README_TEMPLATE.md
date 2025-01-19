# Mp3 Player

<!-- Replace difficulty with score after CTF -->
> Pwn - easy/medium/hard <!-- *points/solves* -->
<!-- Challenge difficulty explained:
- easy: No prerequisites, should be solvable by everyone. A new player should be able to solve this in a couple of hours at most.
- medium: Requires some knowledge of the subject, or a bit of google-fu.
- hard: Requires in-depth knowledge of the subject. Experienced players will find this challenging.
 -->

We found an old mp3 player laying around and decided to connect it to the internet for everyone to listen to its good ol' hits.
However, we might have messed up some of the instructions when setting it up...

Files: [Source code](src)

You can connect to the mp3 player with netcat

```bash
nc motherload.td.org.uit.no 8006
```

**Hint 1**:
Maybe there is a way to call the function printing the flag

**Hint 2**:
Ever heard of a buffer overflow?

[Writeup](writeup/writeup.md)
