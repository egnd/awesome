#!make

MAKEFLAGS += --always-make --no-print-directory
CALL_PARAM=$(filter-out $@,$(MAKECMDGOALS))

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' Makefile | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

%:
	@:

########################################################################################################################

init: ## download and update subrepos
	git submodule update --init

update: init ## update awesome list
	git merge --no-ff source/main -F readme.md
	git add -A
	git commit -m "updates"
	git push origin master
	@echo "All is OK"
