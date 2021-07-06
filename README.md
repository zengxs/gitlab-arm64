# Omnibus GitLab Docker for ARM64

English | [中文](./README.zh-Hans.md)

> Upstream: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker> 


### How to use

The usage is the same as the official docker image.

Refer to the official docker installation documentation:
* <https://docs.gitlab.com/omnibus/docker/>


### Prebuilt versions
`14.0.*`:
* `14.0.2-ce.0`
* `14.0.2-ee.0`
* `14.0.1-ce.0`
* `14.0.1-ee.0`

`13.12.*`:
* `13.12.6-ce.0`
* `13.12.6-ee.0`
* `13.12.5-ce.0`
* `13.12.5-ee.0`

You can pull prebuilt docker image from ghcr.io:
```sh
docker pull ghcr.io/zengxs/gitlab-arm:<version>
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

* Add package `libatomic1` (gitlab require it)
* Change ssh port from `22` to `2222`
