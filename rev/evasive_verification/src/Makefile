
VERSION = 0.1

CC_TUX = gcc
CC_WIN = x86_64-w64-mingw32-gcc

CFLAGS = -Wall -Wextra -std=c11
LIBS = -lcurl -luuid
LIBS_MINGW = I/usr/i686-w64-mingw32/include -L/usr/i686-w64-mingw32/lib -static -static-libstdc++
LDFLAGS = -s 	# strip symbols

SRCS = main.c
OBJS = $(SRCS:.c=.o)

TARGET = evasive_verify
TARGET_WIN = $(TARGET).exe

all: tux dock_build dock_run

tux: $(OBJS)
	$(CC_TUX) $(CFLAGS) $(LDFLAGS)  -o $(TARGET) $^ -mtune=generic $(LIBS)

win: $(OBJS)
	$(CC_WIN) $(CFLAGS) $(LDFLAGS) -o $(TARGET).exe $^ $(LIBS_MINGW) $(libs)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# deprecated
dock_build:
	docker build -t nginx_ev:${VERSION} .

dock_buildx:
	docker buildx build -t evasive_verify:${VERSION} .

dock_run:
	docker run -it --rm -p 8080:8080 --name evasive_verify nginx_ev:${VERSION}

clean:
	rm -f $(OBJS) $(TARGET)*
	docker image rm nginx_ev:${VERSION}

.PHONY: all tux win clean dock_build dock_buildx dock_run
