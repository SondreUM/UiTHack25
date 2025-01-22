# !big_picture writeup

> > web - easy
>
> My "guy" told me that he had a really important message for me that he had to hide.
> He told me that he would leave it in plain sight, but I can't seem to find it!
> The only clue he gave me was that he would use a "big picture" to hide it.
> Can you help me out?
>
> URL: <https://uithack.td.org.uit.no:8001>
>
> [Writeup](writeup/README.md)

## Challenge

The challenge is a simple web challenge where the flag is hidden in the mobile version of the website. This can be inferred by numerous hints in the title, description, and source code of the website.
There are a few main methods to detect mobile devices such as, screen width, user agent, and more recently responsive design.

## Author solutions

Start by checking the source code of the website.
There is a comment containing a hint that the flag is hidden in the mobile version of the website.

```html
<body>
    <h1>There is nothing here!</h1>
    <p>You still here? Go away!</p>
    <!-- Hey buddy you need stop looking at only the big picture!!! 
     Start being more mobile and flexible...-->
</body>
```

Since 'flexible and mobile' is mentioned, use the developer tools in the browser to resize the window to a smaller size to simulate a mobile device. This will not reveal the flag.

Continuing with the mobile theme, try checking for responsive design which is most commonly used today. It uses CSS media queries to change the layout of the website depending on the screen size. However, this would mean that the flag is visible in the source code of the website on all devices, which is not the case here.

The next logical step is to change the user agent to a mobile device, which will reveal the flag. This can be performed by using the developer tools in the browser, or by a CLI tool like curl.

```sh
curl -A "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.150 Mobile Safari/537.36" https://uithack.td.org.uit.no:8001
```

Returns the flag:

```html
<body>
    <h1>You found it!</h1>
    <p>Okay listen closely, I need to you to do something for me.
        Find the cief at Elephant island and say `UiTHack25{Ive_got_a_jar_of_dirt-Cpt.JS}` to him, he will give you a
        flag.
        Get it and come back to me, I will be waiting for you here. Good luck!
    </p>
</body>
```

```txt
UiTHack25{Ive_got_a_jar_of_dirt-Cpt.JS}
```
