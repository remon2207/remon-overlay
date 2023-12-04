# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop
DESCRIPTION='Two factor authentication desktop application'
HOMEPAGE='https://authy.com/'
SNAP_ID='H8ZpNgIoPyvmkgxOWw5MSzsXK1wRZiHn'
SNAP_PREV='22'
SRC_URI="https://api.snapcraft.io/api/v1/snaps/download/${SNAP_ID}_${SNAP_PREV}.snap"
DESTDIR="/opt/${PN}"
LICENSE='MIT'
SLOT='0'
KEYWORDS='~amd64'
DEPEND='sys-fs/squashfs-tools'

src_unpack() {
	unsquashfs -quiet -force -dest "${S}" "${DISTDIR}/${SNAP_ID}_${SNAP_PREV}.snap"
}

src_prepare() {
	eapply_user

	mv "${S}/meta/gui/"{icon,"${PN}"}'.png'
	sed --in-place --expression='s/^\(Icon=\).*/\1authy/' "${S}/meta/gui/${PN}.desktop"
}

src_install() {
	domenu "${S}/meta/gui/${PN}.desktop"
	doicon --size 256 "${S}/meta/gui/authy.png"
	exeinto "${DESTDIR}"
	insinto "${DESTDIR}"
	doexe "${PN}" ./*.so* ./chrome_crashpad_handler
	doins ./*.pak ./*.bin ./*.dat ./*.json
	insopts --mode=0755
	doins -r ./locales ./resources
	dosym "${DESTDIR}/${PN}" "/usr/bin/${PN}"
}
