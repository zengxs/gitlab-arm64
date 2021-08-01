# Omnibus GitLab Docker for ARM64

![CircleCI](https://img.shields.io/circleci/build/gh/zengxs/gitlab-docker?logo=circleci)
![Docker Pulls](https://img.shields.io/docker/pulls/zengxs/gitlab?logo=docker)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/zengxs/gitlab/ce?label=gitlab-ce&logo=docker)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/zengxs/gitlab/ee?label=gitlab-ee&logo=docker)
![Docker Image Version (latest by date)](https://img.shields.io/docker/v/zengxs/gitlab?arch=arm64&logo=docker)

English | [简体中文](./README.zh-Hans.md)

> Upstream: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker>

### How to use

The usage is the same as the official docker image.

Refer to the official docker installation documentation:

- <https://docs.gitlab.com/omnibus/docker/>

### Prebuilt versions

<details>
<summary>14.0.x <kbd>14.0</kbd></summary>

- `14.0.6-ce.0` <kbd>14.0-ce</kbd>
- `14.0.6-ee.0` <kbd>14.0-ee</kbd>
- `14.0.5-ce.0`
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

You can pull prebuilt docker image from DockerHub:

```sh
docker pull zengxs/gitlab:latest
```

> **ce** is community edition, **ee** is enterprise edition.
>
> If you don't know which edition to choose, see <https://about.gitlab.com/install/ce-or-ee/>.
> Or just choose community edition.

### Steps to build image manually

1. Edit [`./RELEASE`](./RELEASE) file, update the `RELEASE_PACKAGE`
   (edition variant, `gitlab-ce` or `gitlab-ee`) and
   `RELEASE_VERSION` (gitlab version, eg `14.0.1-ce.0`).

2. Run `docker build . -t gitlab` to build image

### Differences compared to official dockerfile

- Add package `libatomic1` (gitlab require it)
- Change ssh port from `22` to `2222`
