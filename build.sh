#!/usr/bin/env bash
set -euo pipefail

# Update base system
dnf upgrade -y

# Base system & containers
BASE_PKGS=(
    openssh-server
    podman
    tuned
    systemd-resolved
    systemd-container
    pcp-zeroconf
)

# Virtualization (KVM & modular libvirt daemons)
VIRT_PKGS=(
    qemu-kvm
    libvirt-daemon-kvm
    libvirt-client
)

# Cockpit web management
COCKPIT_PKGS=(
    cockpit
    cockpit-files
    cockpit-machines
    cockpit-networkmanager
    cockpit-ostree
    cockpit-podman
    cockpit-storaged
    cockpit-selinux
)

# Hardware, Firmware & Diagnostics
HARDWARE_PKGS=(
    linux-firmware
    fwupd
    smartmontools
    lm_sensors
    nvme-cli
    pciutils
    usbutils
    ethtool
    btrfs-progs
    udisks2-btrfs
    duperemove
    mdadm
    lvm2
    zram-generator-defaults
)

# CLI Utilities
CLI_PKGS=(
    htop
    btop
    tmux
    curl
    wget
    rsync
    tar
    zstd
    jq
    tree
    bind-utils
    git-core
    nano
    micro
    fish
    fastfetch
    bash-completion
    ncdu
    wireguard-tools
)

# Install all packages
dnf install -y \
    "${BASE_PKGS[@]}" \
    "${VIRT_PKGS[@]}" \
    "${COCKPIT_PKGS[@]}" \
    "${HARDWARE_PKGS[@]}" \
    "${CLI_PKGS[@]}"

# Enable services
systemctl enable \
    sshd.service \
    cockpit.socket \
    tuned.service \
    smartd.service \
    systemd-resolved.service \

# Mask services
systemctl mask \
    rpcbind.service \
    rpcbind.socket \
    systemd-remount-fs.service

# Clean cache
dnf clean all
rm -rf /var/cache/dnf /tmp/* /var/tmp/*
truncate -s 0 /etc/machine-id
