CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = dynamic_memory

all: $(TARGET)

$(TARGET): dynamic_memory.o
	$(CC) $(CFLAGS) $^ -o $@

dynamic_memory.o: dynamic_memory.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
