# Bleeding Heart writeup

> > web - medium
>
> We have identified a server that contains secret information and that is is known to have a security flaw.
> According to trusted sources thev have hired some people from the OpenSSL team that is coming over to fix it
> tomorrow.
>
> URL: <https://uithack-2.td.org.uit.no:8004>


## Challenge

The challenge is based on the Heartbleed bug in OpenSSL, where an exploit allowed senders of heartbeats to specify an arbitrary
length for their message. When the length is longer than the sent message the remaining length would be read from
outside the bounds of the buffer, causing the software to return arbitrary data from system memory.

To avoid security flaws this challenge recreates this bug in safe string buffer.
The flag is hidden in the remaining area of the buffer.

The web page provided issues a test message to the server along with the correct length. The server then responds with
the same message back.

## Author solutions
Following the hint from the name and the reference to OpenSSL leads to googling "bleeding heart openssl".
A quick read of any result on the top page is enough to get the gist of the Heartbleed bug.

Inspecting the source code of the webpage we can see the server connection tester sends a message with an attached length.
Knowing the heartbleed bug is relevant we try sending the same message with a different length,
either in the JS console or using an external HTTP request utility. Doing so results in the server sending more data back.

Thus we try to have the server send more data from memory.
Inspecting the data sent back from outside the buffer we can some random garbage information but cotained inside it is the flag.


## Limitations
The server will cap requests at 4096 bytes. This is likely more than a first attempt, but if the cap is reached the server respons with an error message.
