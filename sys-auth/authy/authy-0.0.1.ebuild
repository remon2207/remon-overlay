# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop
DESCRIPTION="Two factor authentication desktop application"
HOMEPAGE="https://authy.com/"
SNAP_ID="H8ZpNgIoPyvmkgxOWw5MSzsXK1wRZiHn"
SNAP_PREV="22"
SRC_URI="https://api.snapcraft.io/api/v1/snaps/download/${SNAP_ID}_${SNAP_PREV}.snap"
SNAP_DIR="${PORTAGE_BUILDDIR}/distdir"
DESTDIR="/opt/${PN}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND="sys-fs/squashfs-tools"
DEPEND="${RDEPEND}"

src_unpack() {
	echo "Extracting snap file..."
	unsquashfs -q -f -d "${S}" "${SNAP_DIR}/${SNAP_ID}_${SNAP_PREV}.snap"
}

src_prepare() {
	eapply_user
	mv "${S}/meta/gui/icon.png" "${S}/meta/gui/authy.png"
	sed -i 's/^Icon=.*/Icon=Authy/' "${S}/meta/gui/${PN}.desktop"
}

src_install() {
	domenu "${S}/meta/gui/${PN}.desktop"
	doicon -s 256 "${S}/meta/gui/authy.png"
	exeinto "${DESTDIR}"
	insinto "${DESTDIR}"
	doexe "${PN}" libEGL.so libGLESv2.so libffmpeg.so libvk_swiftshader.so libvulkan.so.1
	doins chrome_100_percent.pak chrome_200_percent.pak resources.pak icudtl.dat snapshot_blob.bin v8_context_snapshot.bin
	insopts -m0755
	doins -r locales resources
	doins chrome_crashpad_handler
	dosym "${DESTDIR}/${PN}" "/usr/bin/${PN}"
}
