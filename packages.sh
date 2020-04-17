#!/bin/bash

set -e

cd $(dirname $0)

source PKGBUILD

# Обновляем систему и устанавливаем нужные пакеты
pacman -Suy --needed --noconfirm base
pacman -Suy --needed --noconfirm ${depends[*]}

# Удаляем ненужные пакеты
if test -n "${conflicts[*]}"
then
	pacman -R --noconfirm ${conflicts[*]}
fi

# Обновляем кеш пакетов для PKGFILE
pkgfile --update --quiet
