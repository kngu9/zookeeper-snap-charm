#!/bin/sh

set -eu

export PATH=$SNAP/usr/lib/jvm/default-java/bin:$PATH
unset JAVA_HOME

export ZOO_LOG_DIR=$SNAP_USER_DATA/var/log/zookeeper
export ZOO_CFG_DIR=$SNAP_USER_DATA/etc/zookeeper

mkdir -p $ZOO_LOG_DIR
mkdir -p $ZOO_CFG_DIR

touch $ZOO_LOG_DIR/zookeeper.out

for file in $SNAP/opt/zookeeper/conf/*; do
    [ ! -f $ZOO_CFG_DIR/$(basename $file) ] && cp $file $ZOO_CFG_DIR/$(basename $file)
done


$SNAP/opt/zookeeper/bin/zkServer.sh $@