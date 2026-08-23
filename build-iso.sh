#!/usr/bin/env bash
# ==============================================================================
# DahCore - ISO Builder using mkksiso (Official Red Hat / AlmaLinux method)
# ==============================================================================
set -euo pipefail

OUTPUT_DIR="$(pwd)/output"
ISO_DIR="$(pwd)/iso"
KS_FILE="iso/dahcore.ks"
BOOT_ISO_URL="https://repo.almalinux.org/almalinux/10/BaseOS/x86_64/iso/AlmaLinux-10-x86_64-boot.iso"
BOOT_ISO_NAME="AlmaLinux-10-x86_64-boot.iso"
OUTPUT_ISO="output/dahcore-installer-xfs.iso"

mkdir -p "$OUTPUT_DIR" "$ISO_DIR"

# 1. Check or download base AlmaLinux 10 Boot ISO
if [[ ! -f "$BOOT_ISO_NAME" ]]; then
    echo "==> Downloading official AlmaLinux 10 Boot ISO (~800MB)..."
    curl -L --progress-bar -o "$BOOT_ISO_NAME" "$BOOT_ISO_URL" || {
        echo "Direct AlmaLinux 10 boot URL not ready yet, trying mirrorlist..."
        curl -L --progress-bar -o "$BOOT_ISO_NAME" "https://repo.almalinux.org/almalinux/10-kitten/BaseOS/x86_64/iso/AlmaLinux-10-x86_64-boot.iso"
    }
fi

echo "==> Embedding DahCore XFS Kickstart using mkksiso..."

# 2. Run mkksiso inside a container (no local lorax dependency required on host)
sudo podman run --rm --privileged \
    -v "$(pwd)":/work \
    -w /work \
    quay.io/almalinuxorg/almalinux:10 \
    bash -c "
        dnf install -y lorax-tools >/dev/null 2>&1 || dnf install -y lorax >/dev/null 2>&1
        mkksiso --ks $KS_FILE $BOOT_ISO_NAME $OUTPUT_ISO
    "

echo ""
echo "================================================================================"
echo " ✔ DahCore Installer ISO generated successfully:"
echo "   Path: $OUTPUT_ISO"
echo "================================================================================"
