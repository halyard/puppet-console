# @summary Configure serial console
#
class console (
) {
  case $facts['os']['family'] {
    'Archlinux': { include console::systemd }
    'Arch': { include console::systemd }
    default: { fail("Hostname module does not support ${facts['os']['family']}") }
  }
}
