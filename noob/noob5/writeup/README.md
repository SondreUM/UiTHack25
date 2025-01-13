# Noob - Noob5

> > Noob - *points/solves*
>
> One last time the flag has been stolen. This time they even had courage to invite us to take it back. This must mean they are confident in their countermeasures. We don't really have a choice though. Best of luck
> 
> You can connect to their server with the following command `ssh noob5@uithack.td.org.uit.no -p 6004`
> 
> The password is the flag from the previous noob challenge.
> 
> Use command `exit` to disconnect from the server when you are done.

## Writeup

Log into the server with the given command `ssh noob5@uithack.td.org.uit.no -p 6004` using `UiTHack25{D45h1ng_5ki11s}` as password.

We can see that there is a flag in the home directory using `ls`, but if we try to read it `cat flag.txt` we get an error saying we don't have permission to read it.

To check the permissions on it we can use `ls -l`.

This shows us that the file belongs to the user `root`, and that the group `captain` has read permissions for it. That second group sounds interesting.

To check who is member of that group we can use `grep '^captain:' /etc/group`. This shows us that there is another user called `mr_captain`.

Maybe we could pretend to be that user? This is what the `sudo` command actually does. However most people just know it for running commands as `root` since that is the default user to run a command as with `sudo`. If we want to run a command as another user we simply use the argument `-u` to specify what user we wanna run the command as. Before this we could at leat check if we can run any commands as `mr_captain`. This can be done using the command `sudo -l -U noob5`. It will specify any commands we are allowed to run as other user, and even say if we need a password to do so!

```
User noob5 may run the following commands on ************:
    (mr_captain) NOPASSWD: /usr/bin/cat
```

This means we are allowed to read the flag with `cat` as if we were `mr_captain`, without a password, using the command `sudo -u mr_captain /usr/bin/cat /home/noob5/flag.txt`

```
UiTHack25{I_4M_D4_C4P74IN_N0W}
```