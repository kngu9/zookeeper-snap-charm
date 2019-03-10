
ZOOKEEPER_VERSION := $(shell awk '/version:/ {print $$2}' snap/snapcraft.yaml | head -1 | sed "s/'//g")

.PHONY: all
all: sysdeps snap charm

.PHONY: snap
snap: zk_$(ZOOKEEPER_VERSION)_amd64.snap

zk_$(ZOOKEEPER_VERSION)_amd64.snap:
	SNAPCRAFT_BUILD_ENVIRONMENT_MEMORY=6G snapcraft

.PHONY: fat-charm
fat-charm: zk_$(ZOOKEEPER_VERSION)_amd64.snap
	cp $< charm/zookeeper
	$(MAKE) -C charm/zookeeper

.PHONY: charm
charm: charm/builds/zookeeper

charm/builds/kafka:
	$(MAKE) -C charm/zookeeper

.PHONY: clean
clean: clean-snap clean-charm

.PHONY: clean-snap
clean-snap:
	snapcraft clean

.PHONY: clean-charm
clean-charm:
	$(RM) -r charm/builds charm/deps
	$(RM) charm/zookeeper/*.snap

sysdeps: /snap/bin/charm /snap/bin/snapcraft
/snap/bin/charm:
	sudo snap install charm --classic
/snap/bin/snapcraft:
	sudo snap install snapcraft --classic
