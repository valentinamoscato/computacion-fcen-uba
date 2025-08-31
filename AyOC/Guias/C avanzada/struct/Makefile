CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = struct

all: $(TARGET)

$(TARGET): struct.o
	$(CC) $(CFLAGS) $^ -o $@

struct.o: struct.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
