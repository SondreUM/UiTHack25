CC = gcc
CFLAGS = -fno-stack-protector
TARGET = sc0
SRCS = sc0.c

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
