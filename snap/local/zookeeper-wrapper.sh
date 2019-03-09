#!/bin/sh

set -eu

export PATH=$SNAP/usr/lib/jvm/default-java/bin:$PATH
unset JAVA_HOME

export ZOO_LOG_DIR=$SNAP_COMMON/var/log/zookeeper
export ZOOCFGDIR=$SNAP_COMMON/etc/zookeeper

mkdir -p $ZOO_LOG_DIR
mkdir -p $ZOOCFGDIR

touch $ZOO_LOG_DIR/zookeeper.out

mkdir -p $SNAP_COMMON/data/zookeeper

for file in $SNAP/etc/zookeeper/*; do
    [ ! -f $ZOOCFGDIR/$(basename $file) ] && cp $file $ZOOCFGDIR/$(basename $file)
done

export ZOO_LOG4J_PROP="TRACE, stdout, stderr"
export JVMFLAGS="-Djava.security.auth.login.config=$ZOOCFGDIR/zookeeper-jaas.conf"

$SNAP/opt/zookeeper/bin/zkServer.sh "$@"