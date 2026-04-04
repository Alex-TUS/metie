all: setup

setup:
	mix setup


start server:
	mix phx.server

format:
	mix format

check: check.deps
	mix deps.audit
	mix hex.audit
	MIX_ENV=test mix lint


check.deps:
	mix hex.audit
	mix hex.outdated

clean:
	mix clean
	mix deps.clean --unlock --unused

.PHONY: test
