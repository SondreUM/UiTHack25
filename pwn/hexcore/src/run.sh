#!/bin/sh

bwrap \
    --ro-bind /bin /bin \
    --ro-bind /home /home \
    --ro-bind /lib /lib \
    --ro-bind /lib64 /lib64 \
    --ro-bind /usr /usr \
    --unshare-all \
    hexcore
