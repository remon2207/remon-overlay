# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
DESCRIPTION='A shell parser, formatter, and interpreter with bash support'
HOMEPAGE='https://github.com/mvdan/sh'
SRC_URI="
	https://github.com/mvdan/sh/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	${P}-deps.tar.xz"
S="${WORKDIR}/sh-${PV}"
LICENSE='BSD'
SLOT='0'
KEYWORDS='~amd64'

src_compile() {
	CGO_ENABLED=0 ego build -trimpath -ldflags="-w -s -X=main.version=v${PV}" "./cmd/${PN}"
}

src_install() {
	dobin "${PN}"
}
