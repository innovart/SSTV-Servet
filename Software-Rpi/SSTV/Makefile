#

CFLAGS=-I/u0/markv/include -g
LDFLAGS=-L/u0/markv/lib 
LIBS=-lsndfile -ljpeg -lm

all: robot36

robot36: robot36.o
	$(CC) -o $@ $(LDFLAGS) robot36.o $(LIBS)
