# Copied from: https://github.com/docker-library/docker/blob/3ed3a49381cdce562ce1833284af80f24b29f10e/23/cli/Dockerfile#L1
# Modified further to base off Debian
#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "apply-templates.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM debian:11.7-slim

RUN   apt-get -q update                 \
 &&                                     \
      apt-get install -qq               \
          ca-certificates               \
          wget                          \
          # DOCKER_HOST=ssh://... -- https://github.com/docker/cli/pull/1014
          openssh-client                \
 &&                                     \
      rm -rf /var/lib/apt/lists/*

# ensure that nsswitch.conf is set up for Go's "netgo" implementation (which Docker explicitly uses)
# - https://github.com/moby/moby/blob/v20.10.21/hack/make.sh#L115
# - https://github.com/golang/go/blob/go1.19.3/src/net/conf.go#L227-L303
# - docker run --rm debian:stretch grep '^hosts:' /etc/nsswitch.conf
#RUN [ -e /etc/nsswitch.conf ] && grep '^hosts: files dns' /etc/nsswitch.conf

ENV DOCKER_VERSION 23.0.6

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
		'docker/docker' \
	; \
	rm docker.tgz; \
	\
	docker --version

ENV DOCKER_BUILDX_VERSION 0.10.5
RUN set -eux; \
	\
	dpkgArch="$(dpkg --print-architecture)"; \
	case "$dpkgArch" in \
		'amd64') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-${dpkgArch}"; \
			sha256='2f1995ee6c4e7d75668ff38242ce3381da71bd30a8ca1f648f077b0a066c742b'; \
			;; \
		'armhf') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-arm-v6"; \
			sha256='cd8d8b3fe02b07d60d323af27da53c72c35516e7c8a52e649e3a68582e113e76'; \
			;; \
		'armv7') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-arm-v7"; \
			sha256='a10b60d9c541b30c8f46ed2c8e671c1c775125d6b71ff0b1787204c11ae84ba9'; \
			;; \
		'arm64') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-${dpkgArch}"; \
			sha256='a60d2dfb46cbe66e7fa75c8fd4fc730bcf052e08b8e236df254c24600db388a9'; \
			;; \
		'ppc64le') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-ppc64le"; \
			sha256='1c1ac2bcad35a7d423e093bceba04e3f0d3f4381e534b64e1fb67e0dc932c973'; \
			;; \
		'riscv64') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-riscv64"; \
			sha256='f2da6e8ac73b00bafac1f4ecd76e126e8a3f6740adfcd04fbad0094d30274a55'; \
			;; \
		's390x') \
			url="https://github.com/docker/buildx/releases/download/v${DOCKER_BUILDX_VERSION}/buildx-v${DOCKER_BUILDX_VERSION}.linux-s390x"; \
			sha256='9a64f9248a8fa6d5b114d5599018814a1fc950f1910aa73e4fb9d012ca9bcbe6'; \
			;; \
		*) echo >&2 "warning: unsupported 'docker-buildx' architecture ($dpkgArch); skipping"; exit 0 ;; \
	esac; \
	\
	wget -O 'docker-buildx' "$url"; \
	echo "$sha256 *"'docker-buildx' | sha256sum -c -; \
	\
	plugin='/usr/local/libexec/docker/cli-plugins/docker-buildx'; \
	mkdir -p "$(dirname "$plugin")"; \
	mv -vT 'docker-buildx' "$plugin"; \
	chmod +x "$plugin"; \
	\
	docker buildx version

ENV DOCKER_COMPOSE_VERSION 2.18.1
RUN set -eux; \
	\
	dpkgArch="$(uname -m)"; \
	case "$dpkgArch" in \
		'x86_64') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${dpkgArch}"; \
			sha256='b4e6aff14c30f82ce26e94d37686b5598b3f870ce1e053927c853b4f4b128575'; \
			;; \
		'armhf') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-armv6"; \
			sha256='34430890fe8ab68fe091a2907ebff174d1d6dcfc3d4e87f8c50bb105a2ac8b5f'; \
			;; \
		'armv7') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${dpkgArch}"; \
			sha256='cced34fc17c3689b5e0760b115ef481014eb004370a7b9380fc25eeef55570bb'; \
			;; \
		'aarch64') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${dpkgArch}"; \
			sha256='6d1784542f74806ef0ed4e798d31c91604453eb06b86448b4c60d7df5d5b7afb'; \
			;; \
		'ppc64le') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${dpkgArch}"; \
			sha256='baa21ead951f0b0a0dc191e4dc7718e584961d0fcbb5969004bdcf1950203cde'; \
			;; \
		'riscv64') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${dpkgArch}"; \
			sha256='2e84879a8677bcebda18d7772a86fa107f3745ba693f7c9c397b9fede355e3f2'; \
			;; \
		's390x') \
			url="https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-linux-${dpkgArch}"; \
			sha256='e8d5669b5f11212310d080d239348fe293b783c7357bb1085728fbed69e519c9'; \
			;; \
		*) echo >&2 "warning: unsupported 'docker-compose' architecture ($dpkgArch); skipping"; exit 0 ;; \
	esac; \
	\
	wget -O 'docker-compose' "$url"; \
	echo "$sha256 *"'docker-compose' | sha256sum -c -; \
	\
	plugin='/usr/local/libexec/docker/cli-plugins/docker-compose'; \
	mkdir -p "$(dirname "$plugin")"; \
	mv -vT 'docker-compose' "$plugin"; \
	chmod +x "$plugin"; \
	\
	ln -sv "$plugin" /usr/local/bin/; \
	docker-compose --version; \
	docker compose version

COPY modprobe.sh /usr/local/bin/modprobe
COPY docker-entrypoint.sh /usr/local/bin/

# https://github.com/docker-library/docker/pull/166
#   dockerd-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-generating TLS certificates
#   docker-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-setting DOCKER_TLS_VERIFY and DOCKER_CERT_PATH
# (For this to work, at least the "client" subdirectory of this path needs to be shared between the client and server containers via a volume, "docker cp", or other means of data sharing.)
ENV DOCKER_TLS_CERTDIR=/certs
# also, ensure the directory pre-exists and has wide enough permissions for "dockerd-entrypoint.sh" to create subdirectories, even when run in "rootless" mode
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
# (doing both /certs and /certs/client so that if Docker does a "copy-up" into a volume defined on /certs/client, it will "do the right thing" by default in a way that still works for rootless users)

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
