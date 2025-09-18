CC = gcc
CFLAGS = -Wall -Wextra -pedantic
TARGET = static_v2

all: $(TARGET)

$(TARGET): static_v2.o
	$(CC) $(CFLAGS) $^ -o $@

static_v2.o: static_v2.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm *.o $(TARGET)

.PHONY: all clean
