#!/bin/sh

set -eu

ZOO_LOG_DIR=$SNAP_USER_DATA/var/log/zookeeper
ZOO_CFG_DIR=$SNAP_USER_DATA/etc/zookeeper

mkdir -p $ZOO_LOG_DIR
mkdir -p $ZOO_CFG_DIR

touch $ZOO_LOG_DIR/zookeeper.out

for file in $SNAP/opt/zookeeper/conf/*; do
    [ ! -f $ZOO_CFG_DIR/$(basename $file) ] && cp $file $ZOO_CFG_DIR/$(basename $file)
done

ZOO_LOG_DIR=$ZOO_LOG_DIR ZOOCFGDIR=$ZOO_CFG_DIR $SNAP/opt/zookeeper/bin/zkServer.sh $@