SHELL := /usr/bin/env sh

.PHONY: buildman
buildman:
	ronn --manual "bangin manual" --organization "bangin 0.1.1" --roff bangin.1.md
