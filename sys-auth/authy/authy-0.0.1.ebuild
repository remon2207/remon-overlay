# Copyright 1999-2023 Gentoo Authors
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
	unsquashfs -f -d "${S}" "${DISTDIR}/${SNAP_ID}_${SNAP_PREV}.snap"
}

src_prepare() {
	eapply_user

	mv "${S}/meta/gui/"{icon,"${PN}"}'.png'
	sed -i -e 's/^\(Icon=\).*/\1Authy/' "${S}/meta/gui/${PN}.desktop"
}

src_install() {
	domenu "${S}/meta/gui/${PN}.desktop"
	doicon -s 256 "${S}/meta/gui/authy.png"
	exeinto "${DESTDIR}"
	insinto "${DESTDIR}"
	doexe "${PN}" ./*.so ./*.so.1
	doins ./*.pak ./*.bin ./icudtl.dat
	insopts -m 0755
	doins -r ./locales ./resources
	doins ./chrome_crashpad_handler
	dosym "${DESTDIR}/${PN}" "/usr/bin/${PN}"
}
