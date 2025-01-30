CC = gcc
CFLAGS = -fno-stack-protector -z execstack -no-pie
TARGET = hexcore
SRCS = hexcore.c

all: $(TARGET)

$(TARGET): $(SRCS)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRCS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
