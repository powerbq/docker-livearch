#!/bin/sh

set -e

cd $(dirname $0)

./init.sh
./packages.sh
./save.sh
