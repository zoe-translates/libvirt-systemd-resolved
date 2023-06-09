<!-- markdownlint-disable MD033 -->

# libvirt-systemd-resolved

Libvirt hooks for setting up DNS with systemd resolved.

## Requirements

- Requires Python3
- This obviously requires that you use `systemd-resolved` and not other dns resolvers locally.
This is mostly the case with Ubuntu 20.04, Fedora 34+ and Debian 10.
- You will need libvirt up and running.
- `<domain name="$DOMAIN_NAME"/>` **MUST** be defined. Example xml for default network, with domain `default.kvm` is shown below.
  ```xml
  <network>
    <name>default</name>
    <uuid>25009595-68aa-4888-9c74-e3db45818bed</uuid>
    <forward mode='nat'>
      <nat>
        <port start='1024' end='65535'/>
      </nat>
    </forward>
    <bridge name='virbr0' stp='on' delay='0'/>
    <mac address='52:54:00:74:d1:bf'/>
    <domain name='default.kvm'/>
    <ip address='192.168.122.1' netmask='255.255.255.0'>
      <dhcp>
        <range start='192.168.122.2' end='192.168.122.254'/>
        <host mac='52:54:00:DA:4A:4B' name='ansible' ip='192.168.122.129'/>
      </dhcp>
    </ip>
  </network>
  ```

> Please note that changes in network configuration requires network to be destroyed and redefined.

## Installation

Installing is simple as placing hook in `/etc/libvirt/hooks/network.d` and ensure that it is executable.

```bash
sudo make install
```

## Verification

`resolvectl` should show you per link domains

```bash
resolvectl --no-pager domain
```

## Disallowing Public Suffixes

- Known public suffixes are disallowed from being configured as routing domains
- This is achieved via public suffix list at `/usr/share/publicsuffix/public_suffix_list.dat` This is already installed on most Desktop and server systems.

## Dependencies

- If using Debian, Ubuntu, Linux Mint, Pop!_OS, Raspbian or other debian derivatives,
    ```bash
    apt-get install publicsuffix
    ```
- If using Fedora, CentOS, RHEL, Amazon Linux 2022
    ```bash
    dnf install publicsuffix-list
    ```
- If using ArchLinux, Manjaro or other Arch derivatives,
    ```bash
    pacman -S publicsuffix-list
    ```
- If using OpenSUSE,
    ```bash
    zypper install publicsuffix
    ```
