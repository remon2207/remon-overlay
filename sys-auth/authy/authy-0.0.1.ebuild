# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DESCRIPTION="Two factor authentication desktop application"
HOMEPAGE="https://authy.com/"
FETCH=$(/usr/bin/curl -sL https://api.snapcraft.io/api/v1/snaps/search\?q=authy | /usr/bin/awk -F '"' '{print $10}')
SNAP_ID=$(/bin/echo "${FETCH}" | /usr/bin/awk -F '[/_]' '{print $8}')
SNAP_PREV=$(/bin/echo "${FETCH}" | /usr/bin/awk -F '[_.]' '{print $4}')
SRC_URI="https://api.snapcraft.io/api/v1/snaps/download/${SNAP_ID}_${SNAP_PREV}.snap"
S="${WORKDIR}/${P}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND="sys-fs/squashfs-tools"
DEPEND="${RDEPEND}"

src_prepare() {
	echo "Extracting snap file..."
	unsquashfs -q -f -d "${WORKDIR}/${P}" "${SNAP_ID}_${SNAP_PREV}.snap"
}

src_install() {
	install -d "/opt/${PN}"
	cp -a "${S}/." "/opt/${PN}"
	rm -rf "/opt/${PN}/"/{data-dir,gnome-platform,lib,meta,scripts,usr,*.sh}
}
