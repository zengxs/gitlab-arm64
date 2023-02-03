# GitLab Docker 镜像 (ARM64)

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
[dockerhub-badge-latest-version]: https://img.shields.io/docker/v/zengxs/gitlab/ce?arch=arm64&logo=docker
[ghcr]: https://github.com/zengxs/gitlab-docker/pkgs/container/gitlab-arm

[English](./README.md) | 简体中文

## 项目背景

近年来，ARM 服务器的使用越来越广泛。由于其灵活、小巧、高效和低价，ARM 处理器成为了基础设施的理想选择。

世界上几家顶级云服务商都投资了 ARM 服务器，并推出了自己的 ARM 服务器产品，包括 Amazon AWS、Azure、Google Cloud、Oracle Cloud、华为云等。

GitLab 提供了官方 Docker 镜像，但是官方的 Docker 镜像仅支持 x86_64 架构。
实际上，GitLab 官方早已支持 ARM64 架构，只是官方没有为 ARM64 架构打包对应的 Docker 镜像。

这个项目使用 GitLab 官方的 Dockerfile，为 ARM64 架构打包了对应的 Docker 镜像。

> 官方 Dockerfile: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker>
>
> 本项目基于官方 Dockerfile，只添加了少数几行代码，使其能够在 ARM64 上构建。

## 如何使用

此项目旨在提供一个与官方 x86_64 Docker 镜像行为完全一致的 ARM64 版镜像，因此可以直接参考官方文档使用。

参考 GitLab 官方的 Docker 安装文档:

- <https://docs.gitlab.com/omnibus/docker/>

## 获取镜像

### 从 Docker Hub 获取

此项目已经在 DockerHub 上发布了预构建镜像，你可以直接拉取这些镜像来使用，而无需在本地构建 Docker 镜像。
DockerHub 提供了自 13.12 起的所有小版本 (每个 minor version 至少提供了一个版本) 的 GitLab CE/EE 预构建镜像。

在 [DockerHub][dockerhub] 或 [GitHub Container Registry][ghcr] 查看所有可用的版本。

从 DockerHub 拉取镜像:

```sh
# 拉取最新的 GitLab CE 镜像
docker pull zengxs/gitlab:ce
# 拉取最新的 GitLab EE 镜像
docker pull zengxs/gitlab:ee
# 拉取指定版本的 GitLab CE/EE 镜像
docker pull zengxs/gitlab:15.7.0-ce.0
```

> 提示:
>
> 后缀中带 **CE** 的表示社区版, **EE** 表示企业版。
>
> 社区版是开源免费的版本，企业版需要向 GitLab 购买许可证。
>
> 你可以在 <https://about.gitlab.com/install/ce-or-ee/> 上查看两个版本之间的差异。
> 如果你不知道你需要哪个版本，那么你应该使用社区版。

### 本地自行构建

需要一台 ARM64 架构的 Linux 机器，并且已经安装了 Docker。

1. 克隆本项目:

   ```sh
   git clone https://github.com/zengxs/gitlab-docker.git
   ```

2. 检查需要构建的 GitLab 版本号

   版本号格式为 `major.minor.patch[-ce.0]`，例如 `15.7.0-ce.0`。

   你可以在 <https://packages.gitlab.com/gitlab/gitlab-ce> 或 <https://packages.gitlab.com/gitlab/gitlab-ee> 上查看所有可用的版本。

3. 执行构建

   ```sh
   cd gitlab-docker
   # 构建 GitLab CE 镜像
   docker build . \
      -t gitlab-ce:15.7.0-ce.0
      --build-arg RELEASE_PACKAGE=gitlab-ce \
      --build-arg RELEASE_VERSION=15.7.0-ce.0 \
   # 构建 GitLab EE 镜像
   docker build . \
      -t gitlab-ee:15.7.0-ee.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ee \
      --build-arg RELEASE_VERSION=15.7.0-ee.0
   ```
