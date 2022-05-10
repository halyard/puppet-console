##
# Definitions for systemd
class console::systemd () {
  if $facts['virtual'] == 'kvm' {
    service { 'getty@tty1.service':
      ensure => running,
      enable => true,
    }

    service { 'serial-getty@ttyS0.service':
      ensure => running,
      enable => true,
    }

    file_line { 'grub_input':
      ensure => present,
      path   => '/etc/default/grub',
      line   => 'GRUB_TERMINAL_INPUT="serial"',
      match  => '^GRUB_TERMINAL_INPUT=',
      notify => Exec['update grub'],
    }

    file_line { 'grub_output':
      ensure => present,
      path   => '/etc/default/grub',
      line   => 'GRUB_TERMINAL_OUTPUT="serial"',
      match  => '^GRUB_TERMINAL_OUTPUT=',
      notify => Exec['update grub'],
    }

    file_line { 'grub_serial':
      ensure => present,
      path   => '/etc/default/grub',
      line   => 'GRUB_SERIAL_COMMAND="serial --unit=0 --speed=115200"',
      match  => '^GRUB_SERIAL_COMMAND=',
      notify => Exec['update grub'],
    }

    exec { 'update grub':
      command     => '/usr/bin/grub-mkconfig -o /boot/grub/grub.cfg',
      refreshonly => true,
    }
  }
}
