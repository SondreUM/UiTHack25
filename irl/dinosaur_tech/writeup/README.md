# Dinosaur tech writeup

> > IRL - easy/medium
>
> I found some old media in the attic and would like to know what it says. Luckily I > also found a display at my grandparents that seems to be able to read the media. It > seems to be some kind of message from the ancient times. Can you help me decode it?
>
> Find the old display in room and decode the message for me.

The challenge is based on a flag encoded as morse code. Some noise is has been added since it was created centuries ago, luckily there is a checksum displayed as a binary graph showing which letters are correct.

![Dinosaur tech](./binary-morse.png)

## Writeup

Realise the following:

- The top graph is morse code
- The bottom graph shows which letters should be included in the flag

Then decode the morse code and only include the letters that are correct according to the bottom graph, resulting in the flag:

```txt
UiTHack25 15 M0R53 57111 U53D
UiTHack25{15 M0R53 57111 U53D}
```
