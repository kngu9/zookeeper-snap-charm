#!/bin/sh

set -eu

export PATH=$SNAP/usr/lib/jvm/default-java/bin:$PATH
unset JAVA_HOME

export ZOO_LOG_DIR=$SNAP_COMMON/var/log/zookeeper
export ZOOCFGDIR=$SNAP_COMMON/etc/zookeeper

mkdir -p $ZOO_LOG_DIR
mkdir -p $ZOOCFGDIR

touch $ZOO_LOG_DIR/zookeeper.out

export JMXPORT=${JMXPORT:-9999}

for file in $SNAP/opt/zookeeper/conf/*; do
    [ ! -f $ZOOCFGDIR/$(basename $file) ] && cp $file $ZOOCFGDIR/$(basename $file)
done

$SNAP/opt/zookeeper/bin/zkServer.sh "$@"
