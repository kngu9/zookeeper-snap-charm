
ZOOKEEPER_VERSION := $(shell awk '/version:/ {print $$2}' snap/snapcraft.yaml | head -1 | sed "s/'//g")

.PHONY: all
all: sysdeps snap

.PHONY: snap
snap: zk_$(ZOOKEEPER_VERSION)_amd64.snap

zk_$(ZOOKEEPER_VERSION)_amd64.snap:
	SNAPCRAFT_BUILD_ENVIRONMENT_MEMORY=6G snapcraft

.PHONY: clean-snap
clean-snap:
	snapcraft clean

.PHONY: clean
clean: clean-snap

sysdeps: /snap/bin/charm /snap/bin/snapcraft
/snap/bin/charm:
	sudo snap install charm --classic
/snap/bin/snapcraft:
	sudo snap install snapcraft --classic
