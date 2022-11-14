name='synth'
version='0.6.8'
release='1'
desc='The Open Source Data Generator'
homepage='https://getsynth.com/'
maintainer='s e <iamawacko@protonmail.com>'
architectures=('amd64' 'aarch64' 'arm7' 'arm6' '386')
license=('MIT', 'Apache-2.0')
sources=("https://github.com/shuttle-hq/synth/archive/refs/tags/v${version}.tar.gz")
checksums='18996ebb6a7a8a9d36d961fd7fc1dee38d78b0d03c57ab5681f312600ab5139e'
provides=('synth')
conflicts=('synth')

build_deps=('wget')
build_deps_arch=('rustup')
build_deps_opensuse=('rustup')
build_deps_alpine=('rustup')


_preparer() {
	rustup install nightly
	cd "${srcdir}/${name}-${version}"
	cargo fetch --locked
}

prepare_arch() {
	_preparer()
}

prepare_opensuse() {
	_preparer()
}

prepare_alpine() {
	_preparer()
}

prepare() {
	rustup --version || wget https://sh.rustup.rs -O rustup.sh && sh rustup.sh -y 
	_preparer()
}

build() {
	cd "${srcdir}/${name}-${version}"
	cargo build --frozen --release
}

package() {
	cd "${srcdir}/${name}-${version}"
	install -Dm0755 "target/release/${name}" "${pkgdir}/usr/bin/${name}"
}
