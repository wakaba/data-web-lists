all:

WGET = wget
GIT = git

deps: pmbp-install

local/bin/pmbp.pl:
	mkdir -p local/bin
	$(WGET) -O $@ https://github.com/wakaba/perl-setupenv/raw/master/bin/pmbp.pl

pmbp-install: local/bin/pmbp.pl
	perl local/bin/pmbp.pl --update-pmbp-pl
	perl local/bin/pmbp.pl --install-module JSON \
	     --create-perl-command-shortcut perl
