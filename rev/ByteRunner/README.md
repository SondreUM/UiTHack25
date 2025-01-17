# Build

Commands used to build the challenge files on linux.

## Dependencies

- [zig](https://ziglang.org/)

## Compile for linux

```bash
zig build
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

## How to test

Build the docker image and run it with:

```bash
make dock_build dock_run
```

you might need sudo if you are not in the docker group.
