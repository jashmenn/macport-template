VERSION=1.0.5
RELEASE_DIR=releases/natsort-$(VERSION)
CC=gcc
prefix=/usr
DEFAULT_BINDIR=${prefix}/bin
NATSORT_DEST=natsort

[ "x" = "x$BINDIR" ] && BINDIR=${DEFAULT_BINDIR}

all: natsort
natsort: bin strnatcmp.o natsort.o
	gcc -o $(NATSORT_DEST) strnatcmp.o natsort.o
natsort.o: natsort.c
	gcc -Wall -c -o natsort.o natsort.c
strnatcmp.o: strnatcmp.c
	gcc -Wall -c -o strnatcmp.o strnatcmp.c
clean:
	rm -rf $(NATSORT_DEST) *.o bin/* ./releases/*
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
	install -d $(BINDIR)
	if [ -e $(NATSORT_DEST) ]; then \
	  install -s $(NATSORT_DEST) $(BINDIR)/$(NATSORT_DEST); \
	fi

