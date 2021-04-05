SHELL := /usr/bin/env sh

.PHONY: man
man:
	ronn --manual "bangin manual" --organization "bangin 0.1.1" --roff bangin.1.md

.PHONY: test
test:
	./bangin.test.sh

.PHONY: lint
lint:
	shellcheck ./bangin.sh ./bangin.test.sh
