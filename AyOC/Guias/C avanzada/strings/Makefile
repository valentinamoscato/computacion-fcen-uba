CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = strings

all: $(TARGET)

$(TARGET): strings.o
	$(CC) $(CFLAGS) $^ -o $@

strings.o: strings.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
