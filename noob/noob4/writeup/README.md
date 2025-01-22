# Noob - Noob4

> > Noob - *points/solves*
>
> Shit! The constant back and forth with the flag has corrupted it. I'm trying to read it, but it just doesn't work!
> 
> You can connect to the server with the following command `ssh noob4@uithack.td.org.uit.no -p 6003`
> 
> The password is the flag from the previous noob challenge.
> 
> Use command `exit` to disconnect from the server when you are done.

## Writeup

Log into the server with the given command `ssh noob4@uithack.td.org.uit.no -p 6003` using `UiTHack25{Nev3r_f0rg3771_ctrl_shift_del}` as password.

There are multiple flags there, but the only one actually containing the flag is "-flag.txt ".

The dash and the space in teh file name makes it unable to be read as usual with `cat -flag.txt `

Instead we have to use `--` to cancel out the dash, and then use quotationmarks to speify that there is a space character

```
cat -- "-flag.txt "
UiTHack25{C4t_W0rk5_W0nd3rs}
```