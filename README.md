# GitLab Docker Image for ARM64

[![build-badge][github-actions-badge]][github-actions]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ce]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ee]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version]][dockerhub]

[github-actions]: https://github.com/zengxs/gitlab-docker/actions/workflows/build.yml
[github-actions-badge]: https://github.com/zengxs/gitlab-docker/actions/workflows/build.yml/badge.svg?branch=main
[dockerhub]: https://hub.docker.com/r/zengxs/gitlab/tags
[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/zengxs/gitlab?logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/zengxs/gitlab/ce?label=gitlab-ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/zengxs/gitlab/ee?label=gitlab-ee&logo=docker
[dockerhub-badge-latest-version]: https://img.shields.io/docker/v/zengxs/gitlab/ce?logo=docker
[ghcr]: https://github.com/zengxs/gitlab-docker/pkgs/container/gitlab-arm

English | [简体中文](./README.zh-Hans.md)

## What is this?

In recent years, ARM servers have become more and more widely used. Due to their flexibility,
small size, efficiency, and low price, ARM processors are a great choice for infrastructure.

Several top cloud vendors in the world have invested in ARM servers and launched ARM products,
including Amazon AWS, Azure, Google Cloud, Oracle Cloud, Huawei Cloud, etc.

However, the official GitLab docker image does not provide ARM64 version, which makes it
difficult for ARM users to use GitLab. Actually, GitLab has provided ARM64 version for a long
time, it's just that the official docker image is not built for ARM64.

This project is to build GitLab docker image for ARM64 use GitLab's official dockerfile.

> Upstream dockerfile: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker>
>
> This project is based on the official dockerfile, and only adds a few lines of code to make
> it work on ARM64.

## How to use it?

This project aims to provide an ARM64 image that is eactly the same as the official x86_64
image. So you can use it in the same way as the official image.

Refer to the official docker installation documentation:

- <https://docs.gitlab.com/omnibus/docker/>

## How to get image?

### Pull Pre-built Images

Starting from GitLab CE/EE 13.12, this project continuously builds pre-built images for ARM64.
You can view all available versions on [DockerHub][dockerhub].

**About Editions**

CE represents the community edition, which is open source and free.
EE represents the enterprise edition, which includes more features but requires a license
purchased from [GitLab B.V.](https://about.gitlab.com/pricing/).

You can check <https://about.gitlab.com/install/ce-or-ee/> for the differences between the
two editions. Or you can directly choose the community edition, which should be the choice
for most people.

**About Multi-architecture Images**

To enable some users to use both x86_64 and ARM64 version images simultaneously, starting from
version 16.0.4, all images provide multi-architecture versions. The ARM64 images are built using
Github actions, while the x86-64 version directly uses the corresponding version of the official
image. If you only need an image containing the ARM64 architecture, simply add the `-arm64`
suffix after the tag.

Before version 16.0.4, all images only contain the ARM64 version and the tag does not include the `-arm64` suffix.

#### Pulling from DockerHub

```bash
# Pull the latest version (default to CE version)
docker pull zengxs/gitlab:latest

# Pull the latest EE version
docker pull zengxs/gitlab:ee

# Pull a specified CE version
docker pull zengxs/gitlab:16.0.4-ce.0
```

#### Pull from GHCR

> Deprecated: GHCR is deprecated due to the low usage rate and slowing down of the build process.

```bash
# Pull the latest version (default to CE)
docker pull ghcr.io/zengxs/gitlab-arm:latest

# Pull the latest EE version
docker pull ghcr.io/zengxs/gitlab-arm:ee

# Pull a specific CE version
docker pull ghcr.io/zengxs/gitlab-arm:16.0.4-ce.0
```

### Build image manually

Preqrequisites: ARM64 linux machine, docker installed.

1. Clone this project

   ```sh
   git clone https://github.com/zengxs/gitlab-docker.git
   ```

2. Check the version of GitLab you want to build

   Version used in this example: `15.7.0-ce.0`

   See <https://packages.gitlab.com/gitlab/gitlab-ce> or <https://packages.gitlab.com/gitlab/gitlab-ee> for available versions.

3. Build image

   ```sh
   cd gitlab-docker
   # Build GitLab CE image
   docker build . \
      -t gitlab-ce:15.9.0-ce.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ce \
      --build-arg RELEASE_VERSION=15.9.0-ce.0
   # Build GitLab EE image
   docker build . \
      -t gitlab-ee:15.9.0-ee.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ee \
      --build-arg RELEASE_VERSION=15.9.0-ee.0
   ```
