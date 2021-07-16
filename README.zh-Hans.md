# Omnibus GitLab Docker 镜像 (ARM64)

[English](./README.md) | 简体中文

> 官方 Dockerfile: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker>

此项目用于构建 ARM64 版的 Docker 镜像。Dockerfile 派生自官方的 Omnibus GitLab 项目，仅做了细微更改。

这些镜像可用于一些云服务商提供的 ARM64 服务器，例如:

- 华为云鲲鹏计算平台
- Oracle Cloud Ampere A1 (ARM64) 计算平台
- 或其他运行 ARM64 处理器的云服务器

由于 GitLab 本身需要大量计算资源，在一些低配置的系统中 (如树莓派、路由器等嵌入式设备) 使用此镜像运行 GitLab 可能会出现响应缓慢、或系统报错的现象。

### 如何使用

ARM64 版 GitLab Docker 镜像与 GitLab 官方提供的 x86_64 版镜像在用法上完全相同。

参考 GitLab 官方的 Docker 安装文档:

- <https://docs.gitlab.com/omnibus/docker/>

### 预构建镜像

此项目提供了一些版本的 GitLab 预构建镜像，你可以直接拉取这些镜像来使用，而无需在本地构建 Docker 镜像。

#### 提供的预构建版本

<details>
<summary>14.0.x <kbd>latest</kbd></summary>

- `14.0.5-ce.0` <kbd>latest</kbd>
- `14.0.5-ee.0`
- `14.0.4-ce.0`
- `14.0.4-ee.0`
- `14.0.3-ce.0`
- `14.0.3-ee.0`
- `14.0.2-ce.0`
- `14.0.2-ee.0`
- `14.0.1-ce.0`
- `14.0.1-ee.0`

</details>

<details>
<summary>13.12.x</summary>

- `13.12.8-ce.0`
- `13.12.8-ee.0`
- `13.12.7-ce.0`
- `13.12.7-ee.0`
- `13.12.6-ce.0`
- `13.12.6-ee.0`
- `13.12.5-ce.0`
- `13.12.5-ee.0`

</details>

你可以从 ghcr.io 上拉取这些镜像:

```sh
docker pull ghcr.io/zengxs/gitlab-arm:latest
```

> 后缀中带 **ce** 的表示社区版, **ee** 表示企业版。
>
> 社区版是开源免费的版本，企业版需要向 GitLab 购买许可证。
> 你可以在 <https://about.gitlab.com/install/ce-or-ee/> 上查看两个版本之间的差异。

### 如何在本地手动构建镜像

> 下面的操作需要在一台 ARM64 架构的 Linux 机器上执行。

1. 修改 [`./RELEASE`](./RELEASE) 文件, 编辑其中的两个变量:

   - `RELEASE_PACKAGE`: GitLab 版本类型，可以修改为 `gitlab-ce` (社区版) 或 `gitlab-ee` (企业版)
   - `RELEASE_VERSION`: GitLab 版本号，例如 `14.0.1-ce.0`

2. 执行命令 `docker build . -t gitlab` 即可构建 docker 镜像

### 与 GitLab 官方提供的 x86_64 版 Docker 镜像的差别

- 添加了 `libatomic1` 软件包 (GitLab 依赖此包)
- 修改了 SSH 端口号，从 `22` 改为 `2222`
