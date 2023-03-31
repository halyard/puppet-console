# @summary Configure serial console
#
class console (
) {
  case $facts['os']['family'] {
    'Archlinux': { include console::systemd }
    'Arch': { include console::systemd }
    'Debian': { include console::systemd }
    default: { fail("Console module does not support ${facts['os']['family']}") }
  }
}
