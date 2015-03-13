#!/bin/bash
mkdir -p /opt/openolympus/storage/
mount.xtreemfs xtreemfsdir/openolympus /opt/openolympus/storage 

/opt/jppfnode/JPPF-4.2.5-node/startNode.sh
