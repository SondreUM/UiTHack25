# Pwn - Commlink

>> Pwn - medium
>
>You've intercepted a connection to a commlink terminal. The system looks secure at first glance, but perhaps its design isn't as "secure" as the company claims.

## Writeup

The program reads user commands with `scanf("%63s", command);` and executes a known command. However, when an unrecognized command is entered, it directly prints the user input using `printf(command);`. This opens up for a **format string vulnerability**, allowing us to leak values on the stack. We can use positional formatting to leak the 9th argument on the stack with `%9$s` to get the password to login.

See [exploit.py](./exploit.py) for full exploit script.