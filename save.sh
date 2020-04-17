#!/bin/sh

set -e

cd $(dirname $0)

# Удаляем предыдущую сборку
TARGET=out/latest
rm -Rf $TARGET
mkdir -p $TARGET

# Собираем образ SQUASHFS
VER=$(date +'%y%m%d')
SQUASH=$TARGET'/archlinux_'$VER'.squashfs'
mksquashfs / $SQUASH -ef excludes.txt -wildcards -no-xattrs -no-progress
md5sum $SQUASH > $SQUASH.md5

# Применяем патч для создания загружаемого образа INITRD
tar -zxp -f patch.initcpio.tar.gz -C /
cp linux.preset /etc/mkinitcpio.d/

# Генерируем загружаемый образ INITRD
mkinitcpio -p linux

# Копируем образы загрузки
cp /boot/* $TARGET
