VERSION=1.0.3
RELEASE_DIR=releases/natsort-$(VERSION)
CC=gcc
prefix=/usr

BINDIR=bin
# DEFAULT_BINDIR=${prefix}/bin
# [ "x" = "x$BINDIR" ] && BINDIR=${DEFAULT_BINDIR}

all: natsort
natsort: bin strnatcmp.o natsort.o
	gcc -o bin/natsort strnatcmp.o natsort.o
natsort.o: natsort.c
	gcc -Wall -c -o natsort.o natsort.c
strnatcmp.o: strnatcmp.c
	gcc -Wall -c -o strnatcmp.o strnatcmp.c
clean:
	rm -rf *.o bin/* ./releases/*
releases:
	mkdir releases
bin:
	mkdir bin
tarball: releases clean
	mkdir -p $(RELEASE_DIR)
	cp Makefile Portfile natsort.c strnatcmp.c strnatcmp.h $(RELEASE_DIR)
	cd releases && tar -zcvf natsort-$(VERSION).tar.gz natsort-$(VERSION) 
sums: 
	md5sum releases/natsort-$(VERSION).tar.gz
	shasum releases/natsort-$(VERSION).tar.gz
install: natsort
	mkdir -p $(DESTDIR)
	# install -d $(DESTDIR)
	install $(BINDIR)/natsort $(DESTDIR)
