# Noob - Noob2

> > Noob - *points/solves*
>
> The flag has been stolen once more. They learned from the mistake and they have now taken measures to hide it.
> 
> You can connect to their server with the following command `ssh noob2@uithack.td.org.uit.no -p 6001`
> 
> The password is the flag from the previous noob challenge.
> 
> Read up on the "ls" command if you are not familiar with it.
> 
> Use command `exit` to disconnect from the server when you are done.

## Writeup

Log into the server with the given command `ssh noob2@uithack.td.org.uit.no -p 6001` using `UiTHack25{C4t_W0rk5_W0nd3rs}` as password.

Using `ls -al` we can see that there is a hidden directory called `.secret`.

Inside that directory we can find the flag and print it like we did in noob1.

```
UiTHack25{Hidd3n_but_c4n_b3_Cena}
```