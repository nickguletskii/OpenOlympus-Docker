#!/bin/bash
mkdir -p /opt/openolympus/storage/
mount.xtreemfs localhost/openolympus /opt/openolympus/storage

/opt/jppfnode/JPPF-4.2.5-node/startNode.sh
