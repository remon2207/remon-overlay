# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module
DESCRIPTION='extensible command line tool or library to format yaml files'
HOMEPAGE='https://github.com/google/yamlfmt'
EGO_SUM=(
	"github.com/RageCage64/go-assert v0.2.2"
	"github.com/RageCage64/go-assert v0.2.2/go.mod"
	"github.com/RageCage64/multilinediff v0.2.0"
	"github.com/RageCage64/multilinediff v0.2.0/go.mod"
	"github.com/bmatcuk/doublestar/v4 v4.6.0"
	"github.com/bmatcuk/doublestar/v4 v4.6.0/go.mod"
	"github.com/braydonk/yaml v0.7.0"
	"github.com/braydonk/yaml v0.7.0/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/mitchellh/mapstructure v1.5.0"
	"github.com/mitchellh/mapstructure v1.5.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
)
go-module_set_globals
SRC_URI="https://github.com/google/yamlfmt/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+="${EGO_SUM_SRC_URI}"
LICENSE='Apache-2.0'
SLOT='0'
KEYWORDS='~amd64'

src_compile() {
	CGO_ENABLED=0 ego build -trimpath -ldflags="-w -s -X=main.version=v${PV}" "./cmd/${PN}"
}

src_install() {
	dobin "${PN}"
}
