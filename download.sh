#!/bin/sh

set -e

cd $(dirname $0)

BASEURL=https://mirrors.kernel.org/archlinux/iso
RELEASE=$(wget -q -O - $BASEURL | grep -Eo '"20.+"' | tr -d '"/' | tail -n1)
FILENAME=archlinux-bootstrap-$RELEASE-x86_64.tar.gz

test -f $FILENAME.md5 && md5sum -c $FILENAME.md5 > /dev/null && echo 'Already up to date.' && exit 0

rm -f *.tar.gz *.tar.gz.md5
wget -q -O $FILENAME $BASEURL/$RELEASE/$FILENAME
wget -q -O - $BASEURL/$RELEASE/md5sums.txt | grep $FILENAME > $FILENAME.md5
md5sum -c $FILENAME.md5 > /dev/null

echo 'Done.' && exit 0
