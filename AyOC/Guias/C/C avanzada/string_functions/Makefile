CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = string_functions

all: $(TARGET)

$(TARGET): string_functions.o
	$(CC) $(CFLAGS) $^ -o $@

string_functions.o: string_functions.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
