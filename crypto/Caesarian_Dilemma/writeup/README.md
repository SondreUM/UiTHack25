# crypto - Caesarian Dilemma

> > crypto - *points/solves*
>
> After just having joined the team to exploit EvilCorp you are given the menial task of decrypting a simple intercepted note.
>
> Files: [flag.txt.enc](src/flag.txt.enc)

## Writeup

By seeing "25" in the encrypted flag we can go off the assumption that the
preceeding character should rightfully be "UiTHack". By checking how many
shifts it takes to recreate that string we can infer the shift distance.

If you go right/up you will conclude with 11 in shift distance, or 15 if you
go left/down. At that point all that is left is to decrypt with either a script
like done here [decrypt.go](decrypt.go) or do it by hand.

```txt
JxIWprz25{Hpaps_du_rwdxrt} --> UiTHack25{Salad_of_choice}
```

## Resources

There are several online decoders available for simple ciphers, such as [cryptii](https://cryptii.com/pipes/caesar-cipher) or [CyberChef](https://gchq.github.io/CyberChef/)
