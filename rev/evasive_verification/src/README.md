# Build comands

Commands used to build the challenge files on linux.

## Compile challenge src

### Dependencies

Requires the following dependencies:

- [libcurl](https://curl.se/libcurl/) debian based systems can install with `sudo apt install libcurl4-gnutls-dev`
- [uuid-dev](https://sourceforge.net/projects/libuuid/) debian based systems can install with `sudo apt install uuid-dev`

### Compile for linux

```bash
make tux
```

### Compile for windows

Requires mingw-w64-gcc

```bash
make win
```

## Docker

Build the docker image with:

```bash
make dock_build
```

or with buildx:

```bash
make dock_buildx
```

Run the docker image with:

```bash
make dock_run
```
