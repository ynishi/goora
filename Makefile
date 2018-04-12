.PHONY: build

ORA_VERSION := 12.2

build:
	docker build -t goora ${ORA_VERSION}/golang1.10stretch
	docker build -t goora-dev ${ORA_VERSION}/deisgodev
