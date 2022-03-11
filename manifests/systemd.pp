##
# Definitions for systemd
class console::systemd () {
  if $facts['virtual'] == 'kvm' {
    service { 'getty@tty1.service':
      ensure => absent,
    }

    service { 'serial-getty@ttyS0.service':
      ensure => running,
      enable => true,
    }
  }
}
