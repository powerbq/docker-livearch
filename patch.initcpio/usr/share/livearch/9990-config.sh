#!/usr/bin/ash

Config() {
	CMDLINE="$(cat /proc/cmdline)"

	LIVE_MOUNT=/cdrom
	LIVE_BOOT=live
	LIVE_PREFIX=livearch
	LIVE_MEDIA=LABEL=LiveArch

	test -z "${ROOT}" && ROOT=/new_root

	local PARAM
	for PARAM in ${CMDLINE}
	do
		case "${PARAM}" in
			media=*)
				LIVE_MEDIA="${PARAM#media=}"
				;;

			prefix=*)
				LIVE_PREFIX="${PARAM#prefix=}"
				;;

			boot=*)
				LIVE_BOOT="${PARAM#boot=}"
				;;
		esac
	done

	export LIVE_MOUNT
	export LIVE_BOOT
	export LIVE_PREFIX
	export LIVE_MEDIA
	export ROOT
}
