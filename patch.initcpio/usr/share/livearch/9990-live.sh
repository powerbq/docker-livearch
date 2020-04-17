#!/usr/bin/ash

Live() {
	Config

	mkdir -p ${ROOT}
	mkdir -p ${LIVE_MOUNT}

	mount -o ro $(resolve_device ${LIVE_MEDIA}) ${LIVE_MOUNT}

	cat_to_destination_if_exists /usr/share/livearch/${LIVE_BOOT}          /bin/live-boot
	cat_to_destination_if_exists ${LIVE_MOUNT}/${LIVE_PREFIX}/${LIVE_BOOT} /bin/live-boot

	umount ${LIVE_MOUNT}

	source /bin/live-boot
}
