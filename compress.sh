mount --bind / /mnt
mksquashfs /mnt /tmp/output/root.sqsh -noappend -nopad -e /tmp
