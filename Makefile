all: setup

setup:
	mix setup


start server:
	mix phx.server

format:
	mix format

deps:
	mix hex.audit
	mix hex.outdated

lint:
	mix lint

clean:
	mix clean
	mix deps.clean --unlock --unused

deploy:
	podman build -t docker.io/alexandrupricinoc/metie .
	podman quadlet install -r metie.container
	systemctl --user restart metie
	podman logs -f systemd-metie
