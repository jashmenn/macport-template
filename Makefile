VERSION=1.0.0
all: natsort
natsort: strnatcmp.o natsort.o
	gcc -o natsort strnatcmp.o natsort.o
natsort.o: natsort.c
	gcc -Wall -c -o natsort.o natsort.c
strnatcmp.o: strnatcmp.c
	gcc -Wall -c -o strnatcmp.o strnatcmp.c
clean:
	rm -rf *.o natsort ./releases/*
releases:
	mkdir releases
tarball: releases clean
	tar --no-recursion -zcvf releases/natsort-$(VERSION).tar.gz Makefile Portfile natsort.c strnatcmp.c strnatcmp.h

