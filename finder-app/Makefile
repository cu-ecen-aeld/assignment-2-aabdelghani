# Configurable variables
TARGET = writer
SOURCES = $(wildcard *.c)  # Automatically find all C source files
OBJECTS = $(SOURCES:.c=.o)

# Cross-compilation setup
CROSS_COMPILE ?=
CC = $(CROSS_COMPILE)gcc

# Build targets
all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(LDFLAGS) -o $@ $^

# Compile source files
%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

# Clean target
clean:
	rm -f $(TARGET) $(OBJECTS)

