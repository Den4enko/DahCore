FROM quay.io/fedora/fedora-bootc:44

LABEL org.opencontainers.image.title="DahCore" \
      org.opencontainers.image.description="Minimal, immutable image-based OS for homelab servers" \
      containers.bootc=1

COPY build.sh /tmp/build.sh
RUN bash /tmp/build.sh && rm -f /tmp/build.sh

RUN bootc container lint