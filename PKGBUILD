# Maintainer: haze
pkgname=archer
pkgver=1.0.0
pkgrel=1
pkgdesc="Interactive fzf-based TUI for Arch Linux package management"
arch=('any')
url="https://github.com/Its-Haze/archer"
license=('MIT')
depends=('bash' 'fzf' 'pacman')
optdepends=(
    'yay: AUR support via yay (recommended)'
    'paru: AUR support via paru'
    'pacman-contrib: Dependency tree viewing with pactree'
)
source=("$pkgname-$pkgver.tar.gz::$url/archive/v$pkgver.tar.gz")
sha256sums=('SKIP')

package() {
    cd "$pkgname-$pkgver"
    make PREFIX=/usr DESTDIR="$pkgdir" install
}
