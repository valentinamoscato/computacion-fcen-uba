CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = memory

all: $(TARGET)

$(TARGET): memory.o
	$(CC) $(CFLAGS) $^ -o $@

memory.o: memory.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
