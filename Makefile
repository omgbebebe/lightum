DESTDIR?=/
SHELL = /bin/sh
CC?=gcc
CDEBUGFLAGS= -g -O2
CFLAGS = `pkg-config --cflags dbus-1 --cflags dbus-glib-1` -Wall -Wextra -Wwrite-strings $(CDEBUGFLAGS)
LDFLAGS= `pkg-config --libs dbus-1 --libs dbus-glib-1` $(CDEBUGFLAGS) -lX11 -lXext -lXss -lm
INSTALL = /usr/bin/install -c
INSTALLDATA = /usr/bin/install -c -m 644

srcdir = .
prefix = $(DESTDIR)
bindir = $(prefix)/usr/bin
docdir = $(prefix)/usr/share/doc
mandir = $(prefix)/usr/share/man

OBJ=functions.o dbus.o dbus-session.o configfile.o lightum.o xbacklight.o
BIN=lightum

all: ${OBJ}
	$(CC) $(CFLAGS) ${OBJ} $(LDFLAGS) -o ${BIN}

install: all
	mkdir -p $(bindir)
	$(INSTALL) lightum $(bindir)/lightum
	mkdir -p $(prefix)/etc/xdg/autostart/
	$(INSTALLDATA) lightum.desktop $(prefix)/etc/xdg/autostart/
	mkdir -p $(docdir)/lightum/
	$(INSTALLDATA) $(srcdir)/README $(docdir)/lightum/
	$(INSTALLDATA) $(srcdir)/LICENSE $(docdir)/lightum/
	mkdir -p $(mandir)/man1/
	$(INSTALLDATA) $(srcdir)/lightum.1 $(mandir)/man1/

uninstall:
	rm -rf $(bindir)/lightum
	rm -rf $(prefix)/etc/xdg/autostart/lightum.desktop
	rm -rf $(docdir)/lightum/
	rm -rf $(mandir)/man1/lightum.1

clean:
	rm -f lightum *.o
