CC = gcc
CFLAGS = -Wall -Wextra -pedantic

# Nombre del ejecutable final
TARGET = program

# Todos los archivos objeto
OBJS = main.o list.o type.o

# Regla principal
$(TARGET): $(OBJS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJS)

# Compilación de main.o
main.o: main.c list.h type.h
	$(CC) $(CFLAGS) -c main.c

# Compilación de list.o  
list.o: list.c list.h type.h
	$(CC) $(CFLAGS) -c list.c

# Compilación de type.o
type.o: type.c type.h
	$(CC) $(CFLAGS) -c type.c

# Limpiar archivos compilados
clean:
	rm -f *.o $(TARGET)

# Recompilar desde cero
rebuild: clean $(TARGET)

.PHONY: clean rebuild