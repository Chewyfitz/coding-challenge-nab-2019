CC=gcc
CFLAGS=
DEBUGFLAGS= -D DEBUG

LIBS=-lm

EXE = fib

OBJ = $(EXE).o

$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

fib: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

debug: CFLAGS += $(DEBUGFLAGS)
debug: fib

.PHONY: clean

clean:
	rm -f *.o *~ $(EXE)