#!/usr/bin/ash

resolve_device() {
	for TRY in 0 1 2 3 4 5 6 7 8 9; do
		case $1 in
			UUID=*)
				test -e /dev/disk/by-uuid/${1#UUID=}           && readlink -f /dev/disk/by-uuid/${1#UUID=}           && return 0
			;;
			LABEL=*)
				test -e /dev/disk/by-label/${1#LABEL=}         && readlink -f /dev/disk/by-label/${1#LABEL=}         && return 0
			;;
			PARTUUID=*)
				test -e /dev/disk/by-partuuid/${1#PARTUUID=}   && readlink -f /dev/disk/by-partuuid/${1#PARTUUID=}   && return 0
			;;
			PARTLABEL=*)
				test -e /dev/disk/by-partlabel/${1#PARTLABEL=} && readlink -f /dev/disk/by-partlabel/${1#PARTLABEL=} && return 0
			;;
			*)
				test -b $1                                     && readlink -f $1                                     && return 0
			;;
		esac

		sleep 1
	done

	return 1
}

cat_to_destination_if_exists() {
	test -e $1 && cat $1 > $2
}
