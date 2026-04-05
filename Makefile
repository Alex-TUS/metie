all: setup

setup:
	mix setup


start server:
	mix phx.server

format:
	mix format

lint:
	mix hex.audit
	mix hex.outdated
	mix lint

clean:
	mix clean
	mix deps.clean --unlock --unused

deploy: lint
	podman build -t docker.io/alexandrupricinoc/metie .
	podman quadlet install -r metie.container
	systemctl --user restart metie
	podman logs -f systemd-metie
