# Noob - Noob3

> > Noob - *points/solves*
>
> Third time's the charm. And this time they even remembered to delete the flag so you cannot take it back.
> 
> It should be too late, but who says `history` can't be changed?
> 
> You can connect to their server with the following command `ssh noob3@uithack.td.org.uit.no -p 6002`
> 
> The password is the flag in the previous noob challenge.
> 
> Use command `exit` to disconnect from the server when you are done.

## Writeup

Log into the server with the given command `ssh noob3@uithack.td.org.uit.no -p 6002` using `UiTHack25{Hidd3n_but_c4n_b3_Cena}` as password.

Running the `history` command we can see all commands that they have run on the machine.

The flag can be seen if you scroll up through the bash history.

Alternately you can pipe the history into grep and ask it too look for commands containing UiTHack25 with `history | grep 'UiTHack25'`

```
UiTHack25{Nev3r_f0rg3771_ctrl_shift_del}
```