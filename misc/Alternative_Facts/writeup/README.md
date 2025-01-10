# Misc - Alternate Facts

> > Misc - *points/solves*
>
> Surfing the internet you discover an archive that is being circulated around. What makes it so special?
>
> Files: [flag.rar](../src/flag.rar)

## Writeup

As the challenge suggests, this is Windows specific challenge. The reason it's Windows specific is that it utilizes a feature of NTFS.

By opening the archive in the regular text editor we can see that there is more information than the file has you believe.

If we look closer we can see ":real_flag.txt" among the invalid characters.

This means that there likely is an Alternate Data Stream (ADS) in the file.

Our suspicion can be confirmed by opening a command line and running:

```
dir /r
```

This will show something along the lines of 

```
flag.txt
flag.txt:real_flag.txt:$DATA
```

in the command line.

To extract the real flag from that data stream you can either open it in notepad with

```
notepad flag.txt:real_flag.txt
```

or print out the flag directly in the command line with

```
more < flag.txt:real_flag.txt
```

## Resources

[blog about NTFS ADS](https://blog.netwrix.com/2022/12/16/alternate_data_stream/)
