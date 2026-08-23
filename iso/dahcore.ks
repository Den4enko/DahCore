# ==============================================================================
# DahCore - AlmaLinux Kickstart with XFS
# ==============================================================================

# Deploy DahCore OCI Container
ostreecontainer --url ghcr.io/den4enko/dahcore:latest

# Disk partitioning: Plain partitions formatted as XFS (default Enterprise Linux fs)
zerombr
clearpart --all --initlabel
autopart --type=plain --nohome

# Network & Timezone
network --bootproto=dhcp --device=link --activate
timezone UTC

# Security: Lock root password (or allow interactive setup during installation)
rootpw --lock

# Disable Kdump to save memory
%addon com_redhat_kdump --disable
%end

%post
rm -f /var/lib/systemd/random-seed
%end
