SHELL := /bin/bash

default: run

.PHONY: run prereq

run:
	ansible-playbook init.yaml

prereq:
	apt install ansible
