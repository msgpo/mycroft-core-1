#!/bin/bash

cd /workspace/mycroft-hack

apt update
apt install -y pxz libdbus-1-dev zsync
dpkg-buildpackage -us -uc -b
