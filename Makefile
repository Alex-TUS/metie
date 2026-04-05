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
	mix lint


check.deps:
	mix hex.audit
	mix hex.outdated

clean:
	mix clean
	mix deps.clean --unlock --unused

deploy: check
	podman build -t docker.io/alexandrupricinoc/metie .
	podman quadlet install -r metie.container
	systemctl --user restart metie
	podman logs -f systemd-metie

.PHONY: test
