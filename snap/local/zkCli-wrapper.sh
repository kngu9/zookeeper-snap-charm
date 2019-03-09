#!/bin/sh

set -eu

export ZOO_LOG_DIR=$SNAP_COMMON/var/log/zookeeper
export ZOOCFGDIR=$SNAP_COMMON/etc/zookeeper
export PATH=$SNAP/usr/lib/jvm/default-java/bin:$PATH
unset JAVA_HOME

$SNAP/opt/zookeeper/bin/zkCli.sh "$@"