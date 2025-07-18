ARG BASE_IMAGE=docker.io/ubuntu:24.04
FROM $BASE_IMAGE

ARG BASE_IMAGE
LABEL org.opencontainers.image.authors="GitLab Distribution Team <distribution-be@gitlab.com>" \
      org.opencontainers.image.documentation="https://docs.gitlab.com/ee/install/docker/" \
      org.opencontainers.image.source="https://gitlab.com/gitlab-org/omnibus-gitlab" \
      org.opencontainers.image.title="GitLab Omnibus Docker" \
      org.opencontainers.image.base.name=$BASE_IMAGE

ARG RELEASE_PACKAGE
ARG RELEASE_VERSION

SHELL ["/bin/sh", "-c"]

# Default to supporting utf-8
ENV LANG=C.UTF-8

# Explicitly set supported locales
COPY locale.gen /etc/locale.gen

# Install required packages
# Note: libatomic1 is only required for arm64, but it is small enough to not
# bother about the conditional inclusion logic
RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
      busybox \
      ca-certificates \
      locales \
      openssh-server \
      tzdata \
      wget \
      perl \
      libperl5.38 \
      libatomic1 \
    && locale-gen \
    && cp -a /usr/lib/locale/locale-archive /tmp/locale-archive \
    && DEBIAN_FRONTEND=noninteractive apt-get purge -yq locales \
    && mv /tmp/locale-archive /usr/lib/locale/locale-archive \
    && rm -rf /var/lib/apt/lists/*

# Use BusyBox
ENV EDITOR=/bin/vi
RUN busybox --install \
    && { \
        echo '#!/bin/sh'; \
        echo '/bin/vi "$@"'; \
    } > /usr/local/bin/busybox-editor \
    && chmod +x /usr/local/bin/busybox-editor \
    && update-alternatives --install /usr/bin/editor editor /usr/local/bin/busybox-editor 1

# Remove MOTD
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic
RUN ln -fs /dev/null /run/motd.dynamic

# Legacy code to be removed on 17.0.  See: https://gitlab.com/gitlab-org/omnibus-gitlab/-/merge_requests/7035
ENV GITLAB_ALLOW_SHA1_RSA=false

ARG TARGETARCH

# Copy assets
COPY RELEASE /
COPY assets/ /assets/
# as gitlab-ci checks out with mode 666 we need to set permissions of the files we copied into the
# container to a secure value. Issue #5956
RUN chmod -R og-w /assets RELEASE ; \
  /assets/setup

# Allow to access embedded tools
ENV PATH=/opt/gitlab/embedded/bin:/opt/gitlab/bin:/assets:$PATH

# Resolve error: TERM environment variable not set.
ENV TERM=xterm

# Expose web & ssh
EXPOSE 443 80 22

# Define data volumes
VOLUME ["/etc/gitlab", "/var/opt/gitlab", "/var/log/gitlab"]

# Wrapper to handle signal, trigger runit and reconfigure GitLab
CMD ["/assets/init-container"]

HEALTHCHECK --interval=60s --timeout=30s --retries=5 \
CMD /opt/gitlab/bin/gitlab-healthcheck --fail --max-time 10
