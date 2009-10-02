all: natsort
natsort: strnatcmp.o natsort.o
	gcc -o natsort strnatcmp.o natsort.o
natsort.o: natsort.c
	gcc -Wall -c -o natsort.o natsort.c
strnatcmp.o: strnatcmp.c
	gcc -Wall -c -o strnatcmp.o strnatcmp.c
clean:
	rm -f *.o natsort
