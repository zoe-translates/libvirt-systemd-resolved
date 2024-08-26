SHELL := /bin/bash
.DEFAULT_GOAL := help

.PHONY: help
help: ### This help message
	@printf "%-20s %s\n" "Target" "Help"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?### "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: ### Install hooks (Requires Root)
	@if [[ ! -d /etc/libvirt/hooks/network.d ]]; then mkdir -p /etc/libvirt/hooks/network.d; fi
	install -g root -o root -m 755 systemd-resolved-dns /etc/libvirt/hooks/network.d/systemd-resolved-dns
