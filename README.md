# DahCore

Minimal, immutable image-based OS for homelab servers based on [Fedora bootc](https://github.com/containers/bootc).

---

## 📥 Download Installer ISO

You can download the latest prebuilt installer ISO:

👉 **[DahCore Installer ISO](https://nightly.link/Den4enko/DahCore/workflows/build-iso.yml/main/dahcore-iso.zip)**

### Installation Instructions
1. Download `dahcore-iso.zip` and unpack it.
2. Flash `dahcore-latest.iso` to a USB drive using one of the tools below:
   - [Ventoy](https://www.ventoy.net/) (simply copy the `.iso` onto the drive)
   - [Rufus](https://rufus.ie/) (Windows)
   - [BalenaEtcher](https://etcher.balena.io/) or `dd` (Linux/macOS):
     ```bash
     sudo dd if=dahcore-latest.iso of=/dev/sdX bs=4M status=progress conv=fsync
     ```
3. Boot the server from the USB drive and follow the installer prompts.
