
VERSION = 15

bin_PROGS = prog/lvu prog/lvis prog/lsh
sbin_PROGS = prog/lin prog/lrm prog/lunar prog/lget

plug_LIBS = $(shell ls -1 plugins/*)
core_LIBS = $(shell ls -1 libs/*)
menu_LIBS = $(shell ls -1 menu/*)

etc = etc/config etc/dialogrc
mirrors = $(shell ls -1 mirrors/*)
blacklist = $(shell ls -1 blacklist/*)
compilers = $(shell ls -1 compilers/*)
mans = $(shell ls -1 man/*)

all:

.PHONY:
install: .PHONY
	install -d $(DESTDIR)/etc/lunar
	for F in $(etc) ; do \
	  install -m0644 $$F $(DESTDIR)/etc/lunar/ ; \
	done
	install -d $(DESTDIR)/etc/lunar/local/depends
	install -d $(DESTDIR)/var/lib/lunar/menu
	for F in $(menu_LIBS) ; do \
	  install -m0644 $$F $(DESTDIR)/var/lib/lunar/menu/ ; \
	done
	install -d $(DESTDIR)/var/lib/lunar/functions
	for F in $(core_LIBS) ; do \
	  install -m0644 $$F $(DESTDIR)/var/lib/lunar/functions/ ; \
	done
	install -d $(DESTDIR)/var/lib/lunar/plugins
	for F in $(plug_LIBS) ; do \
	  install -m0644 $$F $(DESTDIR)/var/lib/lunar/plugins/ ; \
	done
	install -d $(DESTDIR)/bin
	for F in $(bin_PROGS) ; do \
	  install -m0755 $$F $(DESTDIR)/bin/ ; \
	done
	install -d $(DESTDIR)/sbin
	for F in $(sbin_PROGS) ; do \
	  install -m0755 $$F $(DESTDIR)/sbin/ ; \
	done
	install -d $(DESTDIR)/etc/lunar/mirrors
	for F in $(mirrors) ; do \
	  install -m0644 $$F $(DESTDIR)/etc/lunar/mirrors/ ; \
	done
	install -d $(DESTDIR)/var/state/lunar
	for F in $(blacklist) ; do \
	  install -m0644 $$F $(DESTDIR)/var/state/lunar/ ; \
	done
	install -d $(DESTDIR)/var/lib/lunar/compilers ; \
	for F in $(compilers) ; do \
	  install -m0755 $$F $(DESTDIR)/var/lib/lunar/compilers/ ; \
	done
	install -d $(DESTDIR)/var/lib/lunar
	install -m0755 misc/bootstrap $(DESTDIR)/var/lib/lunar/
	install -m0644 misc/excluded $(DESTDIR)/var/lib/lunar/
	install -m0644 misc/protected $(DESTDIR)/var/lib/lunar/
	install -m0644 misc/solo $(DESTDIR)/var/lib/lunar/
	install -m0644 misc/sustained $(DESTDIR)/var/lib/lunar/
	install -m0755 misc/unset.sh $(DESTDIR)/var/lib/lunar/
	install -d $(DESTDIR)/lib/lsb
	install -m0644 misc/init-functions $(DESTDIR)/lib/lsb/
	install -d $(DESTDIR)/var/log/lunar/compile
	install -d $(DESTDIR)/var/log/lunar/install
	install -d $(DESTDIR)/var/log/lunar/md5sum
	install -d $(DESTDIR)/var/log/lunar/queue
	install -d $(DESTDIR)/var/cache/lunar
	install -d $(DESTDIR)/var/spool/lunar
	for F in $(mans) ; do \
	  EXT=`echo $$F | sed 's/.*[.]//'` ; \
	  install -d $(DESTDIR)/usr/share/man/man$$EXT ; \
	  install -m0644 $$F $(DESTDIR)/usr/share/man/man$$EXT/ ; \
	done
	# easy way out for the docs:
	install -d $(DESTDIR)/usr/share/doc/lunar
	cp -av doc $(DESTDIR)/usr/share/doc/lunar/

tag:
	git tag v$(VERSION)

dist:
	git archive --format=tar --prefix="lunar-$(VERSION)/" v$(VERSION) | bzip2 > lunar-$(VERSION).tar.bz2

tell:
	@echo "lunar-$(VERSION).tar.bz2"
