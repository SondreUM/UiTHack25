# evasive_verify writeup

> > Rev - medium
>
> EvilCorp has installed a new security system to verify subscriptions. Can you bypass it?
>
> Files: [elf](src/evasive_verify)
>
> Hint 1. It seems like they found a way to verify the key without actually storing it in the binary executable.
> Where could they have hidden it, while still being accessible?"
>
> [Writeup](writeup/README.md)

## Author solutions

### Local capture

The binary will attempt a local connection to `localhost:8080`. Start a local server to capture the URL address used to retrieve the key.

Setup netcat to listen on port 8080

```bash
nc -lvp 8080
```

then run the binary

```bash
./evasive_verify UiTHack{}
```

Gives:

```txt
$ nc -lvp 8080
Listening on 0.0.0.0 8080
Connection received on localhost 44926
GET /c2850b16-2c58-b061-c285-0b162c58b061 HTTP/1.1
Host: localhost:8080
User-Agent: hackerman/1.0
Accept: */*
```

The key can be found at the url address `http://uithack.no:5005/c2850b16-2c58-b061-c285-0b162c58b061`

### Debugging

Use a debugger with breakpoints to capture the key during runtime comparison.

```bash
gdb ./evasive_verify


```

### Network capture

Capture the local network traffic with a tool like Wireshark.
