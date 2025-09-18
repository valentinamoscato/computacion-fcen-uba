CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = struct_v2

all: $(TARGET)

$(TARGET): struct_v2.o
	$(CC) $(CFLAGS) $^ -o $@

struct_v2.o: struct_v2.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
