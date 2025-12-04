# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gkrellm-plugin multilib toolchain-funcs

MY_P=${P/-/_}

DESCRIPTION="an Image-Watcher-Plugin for GKrellM2"
HOMEPAGE="http://gkrellkam.sourceforge.net"
SRC_URI="https://downloads.sourceforge.net/gkrellkam/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc sparc x86"

RDEPEND="
	app-admin/gkrellm:2[X]
	net-misc/wget"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

PATCHES=(
	"${FILESDIR}"/${P}-makefile.patch
	"${FILESDIR}"/${P}-r1-pkgconfig.patch
	"${FILESDIR}"/${P}-r2-typo-fixes.patch
	"${FILESDIR}"/${P}-r2-disable-default-image-source.patch
	"${FILESDIR}"/${P}-r2-https-support.patch
	"${FILESDIR}"/${P}-r2-allow-extra-wget-options.patch
	"${FILESDIR}"/${P}-r2-mask-unused-variables.patch
	"${FILESDIR}"/${P}-r2-gcc-15.patch
	"${FILESDIR}"/${P}-r2-atexit.patch
	"${FILESDIR}"/${P}-r2-ignore-system-return.patch

)

src_compile() {
	tc-export PKG_CONFIG
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}"
}

src_install() {
	local PLUGIN_SO=( ${PN}2$(get_modname) )
	local PLUGIN_DOCS=( example.list )

	gkrellm-plugin_src_install
	doman gkrellkam-list.5
}
