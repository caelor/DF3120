#!/bin/bash

. "$CONF_BASE"/arch/armv4t.sh

board_set_versions() {
	hset linux version "2.6.36.3"
	TARGET_FS_SQUASH=0
	TARGET_INITRD=0
	TARGET_SHARED=1
# Pick a size, any size.
#   16384   :   16M
#   32768   :   32M
#   DEFAULT IS 62M - for crappy cards.
	TARGET_FS_EXT_SIZE=63488
#   63488   :   62M
#   64512   :   63M
#       size is in BYTES, btw :)
	hset uboot url "git!git://repo.or.cz/u-boot-openmoko/parrot-frames.git#uboot-df3120-git.tar.bz2"
}

board_prepare() {
	TARGET_PACKAGES+=" plftool"
	TARGET_PACKAGES+=" strace gdbserver picocom uboot"
	TARGET_PACKAGES+=" bluez btscanner libsdl"
	TARGET_PACKAGES+=" sdlplasma sdlvoxel"
#	TARGET_PACKAGES+=" kobodeluxe"
#	TARGET_PACKAGES+=" sdldoom"
	TARGET_PACKAGES+=" dropbear"
	TARGET_PACKAGES+=" dispinfo"
	TARGET_PACKAGES+=" disptest"
	TARGET_PACKAGES+=" dispwrite"
	TARGET_PACKAGES+=" disppic"
        TARGET_PACKAGES+=" xorgserver xorgvideofbdev"
	hset dbus deploy false
}

df3120-deploy-linux-bare() {
	deploy-linux-bare
	cp "$BUILD"/kernel.ub "$ROOTFS"/linux
}

df3120-deploy-uboot() {
	# make sure the u-boot is aligned on 512 blocks, for mtd_debug
	deploy dd if=u-boot.bin of="$ROOTFS"/u-boot.bin bs=512 conv=sync
}
