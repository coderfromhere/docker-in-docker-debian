#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM docker-on-debian:23-cli

# https://github.com/docker/docker/blob/master/project/PACKAGERS.md#runtime-dependencies
RUN   set -eux;                                       \
      apt-get -q update                               \
 &&                                                   \
      apt-get install -qq --no-install-recommends     \
          btrfs-progs                                 \
          e2fsprogs                                   \
		  iptables                                    \
		  openssl                                     \
          procps                                      \
          # in place of shadow (it's a source package in debian that expands into 3 binary packages)
		  login passwd uidmap                         \
		  xfsprogs                                    \
		  lzma xz-utils                               \
          # pigz: https://github.com/moby/moby/pull/35697 (faster gzip implementation)
          pigz                                        \
 &&                                                   \
      rm -rf /var/lib/apt/lists/*

# We explicitly Disable ZFS because it's not recommended by default:
# see https://docs.docker.com/storage/storagedriver/zfs-driver/
#     > However, at this point in time it is not recommended to use the zfs Docker storage driver for production use
#     > unless you have substantial experience with ZFS on Linux.
ENV DOCKER_BUILDTAGS='exclude_graphdriver_zfs'

# TODO aufs-tools

# set up subuid/subgid so that "--userns-remap=default" works out-of-the-box
RUN set -eux; \
	addgroup --system dockremap; \
	adduser --system --ingroup dockremap dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

RUN set -eux; \
	\
	dpkgArch="$(uname -m)"; \
	case "$dpkgArch" in \
		'x86_64') \
			url="https://download.docker.com/linux/static/stable/${dpkgArch}/docker-${DOCKER_VERSION}.tgz"; \
			;; \
		'armhf') \
			url="https://download.docker.com/linux/static/stable/armel/docker-${DOCKER_VERSION}.tgz"; \
			;; \
		'armv7') \
			url="https://download.docker.com/linux/static/stable/armhf/docker-${DOCKER_VERSION}.tgz"; \
			;; \
		'aarch64') \
			url="https://download.docker.com/linux/static/stable/${dpkgArch}/docker-${DOCKER_VERSION}.tgz"; \
			;; \
		*) echo >&2 "error: unsupported 'docker.tgz' architecture ($dpkgArch)"; exit 1 ;; \
	esac; \
	\
	wget -O 'docker.tgz' "$url"; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
		--no-same-owner \
# we exclude the CLI binary because we already extracted that over in the "docker:23-cli" image that we're FROM and we don't want to duplicate those bytes again in this layer
		--exclude 'docker/docker' \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	containerd --version; \
	ctr --version; \
	runc --version

# https://github.com/docker/docker/tree/master/hack/dind
ENV DIND_COMMIT 1f32e3c95d72a29b3eaacba156ed675dba976cb5

RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
