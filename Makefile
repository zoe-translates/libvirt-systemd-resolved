SHELL := /bin/bash
.DEFAULT_GOAL := help

export REPO_ROOT := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

.PHONY: help
help: ### This help message
	@printf "%-20s %s\n" "Target" "Help"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?### "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

.PHONY: install
install: ### Install hooks (Requires Root)
	@echo "Installing Hooks"
	@if [[ ! -e /etc/libvirt/hooks/network.d ]]; then mkdir /etc/libvirt/hooks/network.d; fi
	install -g root -o root -m 644 psldata.py /etc/libvirt/hooks/network.d/psldata.py
	install -g root -o root -m 755 systemd-resolved-dns /etc/libvirt/hooks/network.d/psldata.pysystemd-resolved-dns
