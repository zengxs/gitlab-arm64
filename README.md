# GitLab Docker Image for ARM64

[![build-badge][github-actions-badge]][github-actions]
[![Docker Hub][dockerhub-badge]][dockerhub]

- GitLab CE: [![Docker Image Size (tag)][dockerhub-badge-image-size-ce]][dockerhub]
- GitLab EE: [![Docker Image Size (tag)][dockerhub-badge-image-size-ee]][dockerhub]

[github-actions]: https://github.com/doingit4science/gitlab-arm64/actions/workflows/docker-build.yml
[github-actions-badge]: https://github.com/doingit4science/gitlab-arm64/actions/workflows/docker-build.yml/badge.svg?branch=main
[dockerhub]: https://hub.docker.com/r/doingit4science/gitlab-arm64
[dockerhub-badge]: https://img.shields.io/docker/pulls/doingit4science/gitlab-arm64?logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/doingit4science/gitlab-arm64/ce?label=ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/doingit4science/gitlab-arm64/ee?label=ee&logo=docker

## Overview

As the tech landscape evolves, ARM servers are gaining traction for their compact design, cost-effectiveness, and energy efficiency. Major cloud providers, including AWS, Azure, Google Cloud, Oracle Cloud, and Huawei Cloud, are expanding their offerings to include ARM-based solutions.

Despite this trend, the official GitLab Docker image lacks an ARM64 variant, posing a challenge for ARM users who wish to leverage GitLab. Although GitLab has long supported ARM64, this compatibility hasn't extended to its official Docker image.

Our project addresses this gap by providing a GitLab Docker image tailored for ARM64, utilizing GitLab's own Dockerfile as a foundation.

> Source Dockerfile: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker>
>
> This initiative enhances the official Dockerfile with minimal modifications to ensure ARM64 compatibility.

## Usage

Our goal is to deliver an ARM64 image that mirrors the official x86_64 version in functionality. You can deploy this image just as you would the standard release.

For installation guidance, refer to the official Docker documentation:

- <https://docs.gitlab.com/omnibus/docker/>

## Acquiring the Image

### Downloading Pre-built Images

From version 18.1.2 onwards, we've been consistently compiling pre-built ARM64 images. Explore the entire range of versions on [Docker Hub][dockerhub].

**Edition Information**

The Community Edition (CE) is the open-source version that's freely available without GitLab's official backing.

The Enterprise Edition (EE) encompasses the full-feature set of GitLab and, while also free, offers paid upgrades for enhanced capabilities and official support.

GitLab endorses the EE version for all users. For further details, please visit <https://about.gitlab.com/install/ce-or-ee/>.

**ARM64 Focus**

This project provides ARM64-only images for both GitLab CE and EE, automatically built and published to Docker Hub. Images are tagged with the GitLab version number and include edition-specific tags (ce/ee) plus a `latest` tag for the most recent CE release.

**Update Strategy**

The update process is fully automated. A GitHub Action checks daily for new GitLab releases and automatically builds and publishes new ARM64 images for both CE and EE editions when detected. This ensures that new GitLab versions are available as ARM64 images within hours of their official release, without any manual intervention required.

#### Retrieving Images from Docker Hub

```bash
# Fetch the latest CE version
docker pull doingit4science/gitlab-arm64:latest

# Fetch the latest EE version
docker pull doingit4science/gitlab-arm64:ee

# Fetch a specific CE release
docker pull doingit4science/gitlab-arm64:18.0.2-ce

# Fetch a specific EE release
docker pull doingit4science/gitlab-arm64:18.0.2-ee
```

### Building the Image Yourself

Requirements: ARM64 Linux system with Docker.

1. Clone the repository:

   ```sh
   git clone https://github.com/doingit4science/gitlab-arm64
   ```

2. Select the GitLab version to build:

   Example version: `16.7.3-ce.0`

   Visit <https://packages.gitlab.com/gitlab/gitlab-ce> or <https://packages.gitlab.com/gitlab/gitlab-ee> for a list of available versions.

3. Compile the image:

   ```sh
   cd gitlab-arm64
   # Build GitLab CE for ARM64
   docker build . \
      -t gitlab-ce:18.0.2-ce.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ce \
      --build-arg RELEASE_VERSION=18.0.2-ce.0
   # Build GitLab EE for ARM64
   docker build . \
      -t gitlab-ee:18.0.2-ee.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ee \
      --build-arg RELEASE_VERSION=18.0.2-ee.0
   ```

## Contributing

I welcome everyone in the community to contribute to this project! If you're working with ARM64 or x86-64 and run into any issues or have questions during deployment, please feel free to reach out. I am committed to assisting you and providing answers to the best of my ability.

I also invite you to submit pull requests. If you come across a problem that is specific to the ARM64 architecture (and not present in the official x86-64 version), your contributions are highly appreciated. By sharing your fixes and enhancements, you can help improve the project for all ARM64 users.

Let's work together to ensure the GitLab Docker image is as reliable and user-friendly as possible. Your input and contributions can make a significant difference!
