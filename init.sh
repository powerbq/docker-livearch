#!/bin/sh

set -e

cd $(dirname $0)

# Готовим PACMAN
pacman-key --init
pacman-key --populate archlinux

# Отменяем создание образов INITRD
mkdir /etc/mkinitcpio.d
truncate -s 0 /etc/mkinitcpio.d/linux.preset

# Используем PKGBUILD из примера, если другого нет
test -f PKGBUILD || cp PKGBUILD.example PKGBUILD
