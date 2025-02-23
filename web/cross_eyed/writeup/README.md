# Cross Eyed writeup

> > Web - hard
>
>  We have acquired access to the screen of a user "Bobby" with the necessary privileges to view the codes to the factory.
>    Unfourtunately he seems to have left for the weekend and we need to access it before he returns.
>    We've managed to send him messages, but he's not there to read them.
>    The connection isn't all that great, but we're sure you can make do.
>
> URL: <https://uithack-2.td.org.uit.no:8010>
>
> [Writeup](writeup/README.md)

## Challenge

The challenge is based on cross site scripting (XSS) vulnerabilities.
The flag is available in plaintext on "Bobby"s computer which the participant is given a supposedly live feed of.
The user can also send messages to Bobby that will display on his computer, this is the intended avenue for XSS.


## Author solutions
Playing around with the webpage it is quickly appearent that the chats are linked together.
This allows us to send chat messages to Bobby. We can also see an editor with a flag.txt file open.

If we have previous experience with XSS we might try inserting a h1 element into the chat. Attempting so proves
that it works, the chat is not being sanitized. We can then attempt to inject a script tag that will execute our code.
Trying something simple like rewriting the body element we discover that it works, the site is susceptible to XSS.
```html
<script>document.body.innerHTML="XSS Worked!"</script>
```

From here there are many ways to get ahold of the flag, we could attempt to remove the chat window that is blocking the
editor from view. We could also try to have a script send the entire page HTML to a remote server such as a Pastebin.
Alternatively a very simple solution, since we know the format of the flag, we can use a regular expression to extract it from the page.

We send Bobby a message with the following content:
```html
<script>const re = /UiTHack25{.+}/; document.body.innerHTML=re.exec(document.body.innerHTML)</script>
```

And just like that the page body is replaced with the flag, the challenge has been solved.
