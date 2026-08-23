#!/usr/bin/env bash
set -euo pipefail

# Update base system
dnf upgrade -y

# Enable repositories
dnf install -y epel-release

# Base system & containers
BASE_PKGS=(
    podman
    tuned
    systemd-resolved
    systemd-container
)

# Cockpit web management
COCKPIT_PKGS=(
    cockpit-ws
    cockpit-system
    cockpit-machines
    cockpit-podman
    cockpit-storaged
    cockpit-networkmanager
)

# Hardware & Diagnostics
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
)

# Install packages
dnf install -y \
    "${BASE_PKGS[@]}" \
    "${COCKPIT_PKGS[@]}" \
    "${HARDWARE_PKGS[@]}" \
    "${CLI_PKGS[@]}"

# Enable services
systemctl enable cockpit.socket tuned.service smartd.service systemd-resolved.service

# Clean cache, runtime artifacts, and unneeded state
dnf clean all
rm -rf /var/cache/* /var/log/* /var/tmp/* /tmp/* /run/* /var/lib/dnf
truncate -s 0 /etc/machine-id