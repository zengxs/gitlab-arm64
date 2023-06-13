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
[dockerhub-badge-latest-version]: https://img.shields.io/docker/v/zengxs/gitlab/ce?logo=docker
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

### 拉取预构建镜像

这个项目自 GitLab CE/EE 13.12 起，持续为 ARM64 构建预构建镜像，你可以从 [DockerHub][dockerhub] 中查看所有可用的版本。

**关于版本 CE/EE**

CE 版本代表社区版，这个版本是开源免费的。EE 版本代表企业版，这个版本包含更多功能但是需要向 [GitLab 公司](https://about.gitlab.com/pricing/)付费购买许可证。

你可以查看 <https://about.gitlab.com/install/ce-or-ee/> 了解两个版本之间的差异。或者你可以直接选择社区版，这应该是大多数人的选择。

**关于多架构镜像**

为了方便部分用户同时使用 x86-64 和 arm64 版本镜像 (比如在同时包含 x86-64 和 arm64 机器的集群中调度 GitLab)，自 16.0.4 开始，所有镜像提供多架构版本。其中 arm64 镜像使用 Github actions 构建，x86-64 版本则直接使用对应版本的官方镜像。

这意味着你不论在 x86-64 机器还是在 arm64 机器上都只需要使用一个标签拉取镜像即可使用。x86-64 机器会自动拉取对应版本的官方 gitlab 镜像，而 arm64 机器则会拉取此项目构建的镜像。

如果需要仅包含 arm64 架构的镜像，只需要在 tag 后面添加 `-arm64` 后缀 即可。16.0.4 版本之前所有镜像都只包含 arm64 版本且 tag 中不包含 `-arm64` 后缀。

#### 从 DockerHub 拉取镜像

```bash
# 拉取最新版本 (默认为 CE 版本)
docker pull zengxs/gitlab:latest

# 拉取最新 EE 版本
docker pull zengxs/gitlab:ee

# 拉取指定 CE 版本
docker pull zengxs/gitlab:16.0.4-ce.0
```

#### 从 GHCR 拉取

> 由于使用人数较少，且会拖慢 GitHub Actions 构建速度，现已废弃，自 16.0.4 版本之后不再更新。

```bash
# 拉取最新版本 (默认为 CE 版本)
docker pull ghcr.io/zengxs/gitlab-arm:latest

# 拉取最新 EE 版本
docker pull ghcr.io/zengxs/gitlab-arm:ee

# 拉取指定 CE 版本
docker pull ghcr.io/zengxs/gitlab-arm:16.0.4-ce.0
```

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
      -t gitlab-ce:15.9.0-ce.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ce \
      --build-arg RELEASE_VERSION=15.9.0-ce.0
   # 构建 GitLab EE 镜像
   docker build . \
      -t gitlab-ee:15.9.0-ee.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ee \
      --build-arg RELEASE_VERSION=15.9.0-ee.0
   ```
