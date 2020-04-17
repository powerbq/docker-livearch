
index() {
	echo $1 | awk -F '.' '{ print $NF }'
}

repack() {
	echo $1
	cd patch.$(index $1)
	tar -zcpf ../patch.$(index $1).tar.gz .
}

repack $1
