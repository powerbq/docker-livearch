#!/usr/bin/ash

export PATH=/usr/bin:/usr/sbin:/bin:/sbin

for SCRIPT in /usr/share/livearch/????-*; do
	if [ -e "${SCRIPT}" ]; then
		source ${SCRIPT}
	fi
done


mkdir -p /var/log

Live > /var/log/livearch.log 2>&1

cp --parents /var/log/livearch.log ${ROOT}
