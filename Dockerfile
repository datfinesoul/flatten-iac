# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
ARG BUILDARCH
RUN echo aaa $BUILDARCH

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/
# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
# BUILDPLATFORM — matches the current machine. (e.g. linux/amd64)
# BUILDOS — os component of BUILDPLATFORM, e.g. linux
# BUILDARCH — e.g. amd64, arm64, riscv64
# BUILDVARIANT — used to set ARM variant, e.g. v7
# TARGETPLATFORM — The value set with --platform flag on build
# TARGETOS - OS component from --platform, e.g. linux
# TARGETARCH - Architecture from --platform, e.g. arm64
# TARGETVARIANT

# https://github.com/orgs/community/discussions/25241

# BUG
# https://github.com/nektos/act/issues/1594
