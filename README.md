# GitLab Docker Image for ARM64

[![build-badge][github-actions-badge]][github-actions]
[![Docker Pulls][dockerhub-badge-pulls]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ce]][dockerhub]
[![Docker Image Size (tag)][dockerhub-badge-image-size-ee]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ce]][dockerhub]
[![Docker Image Version (latest by date)][dockerhub-badge-latest-version-ee]][dockerhub]

[github-actions]: https://github.com/zengxs/gitlab-docker/actions/workflows/build.yml
[github-actions-badge]: https://github.com/zengxs/gitlab-docker/actions/workflows/build.yml/badge.svg?branch=main
[dockerhub]: https://hub.docker.com/r/zengxs/gitlab/tags
[dockerhub-badge-pulls]: https://img.shields.io/docker/pulls/zengxs/gitlab?logo=docker
[dockerhub-badge-image-size-ce]: https://img.shields.io/docker/image-size/zengxs/gitlab/ce?label=gitlab-ce&logo=docker
[dockerhub-badge-image-size-ee]: https://img.shields.io/docker/image-size/zengxs/gitlab/ee?label=gitlab-ee&logo=docker
[dockerhub-badge-latest-version-ce]: https://img.shields.io/docker/v/zengxs/gitlab/ce?logo=docker
[dockerhub-badge-latest-version-ee]: https://img.shields.io/docker/v/zengxs/gitlab/ee?logo=docker

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

From version 13.12 onwards, we've been consistently compiling pre-built ARM64 images. Explore the entire range of versions on [DockerHub][dockerhub].

**Edition Information**

The Community Edition (CE) is the open-source version that's freely available without GitLab's official backing.

The Enterprise Edition (EE) encompasses the full-feature set of GitLab and, while also free, offers paid upgrades for enhanced capabilities and official support.

GitLab endorses the EE version for all users. For further details, please visit <https://about.gitlab.com/install/ce-or-ee/>.

**Multi-Architecture Support**

As of version 16.0.4, our images support multiple architectures, accommodating environments with mixed x86-64 and ARM64 hardware. The ARM64 images are produced via GitHub Actions, while the x86-64 images are sourced directly from the official GitLab builds.

This unified tagging system means you can pull the correct image for your architecture without having to specify it explicitly. For x86-64 systems, the official GitLab image will be retrieved, whereas ARM64 systems will receive the image compiled by this project.

For ARM64-only images, append the `-arm64` suffix to the tag name. Prior to version 16.0.4, images were exclusively ARM64 and did not require the suffix.

**Update Strategy**

The update process for our image is semi-automated. A GitHub Action is configured to scan for new releases from the upstream source every day. If there are any, it automatically creates a pull request with the updates. However, these pull requests require my manual oversight to ensure there are no critical changes in the upstream Dockerfile that could affect our build. While I strive to merge updates promptly, there may be occasions when a pull request isn't noticed right away. Typically, the delay won't exceed one week.

When it comes to versioning, once a new minor release is available (indicated by an increment in the middle digit of the version number), I will shift focus to that new release. For example, if we're at version 16.6.2 and 16.7.0 is released, I will transition to the latest version. Subsequent patch updates for the 16.6.x series will not be maintained. I understand this may cause inconvenience, and I apologize for any issues this might cause. The limitation arises from a practical standpoint, as maintaining multiple versions concurrently is beyond my current capacity.

#### Retrieving Images from DockerHub

```bash
# Fetch the latest version (defaults to CE)
docker pull zengxs/gitlab:latest

# Fetch the latest EE version
docker pull zengxs/gitlab:ee

# Fetch a specific CE release
docker pull zengxs/gitlab:16.7.3-ce.0
```

### Building the Image Yourself

Requirements: ARM64 Linux system with Docker.

1. Clone the repository:

   ```sh
   git clone https://github.com/zengxs/gitlab-arm64
   ```

2. Select the GitLab version to build:

   Example version: `16.7.3-ce.0`

   Visit <https://packages.gitlab.com/gitlab/gitlab-ce> or <https://packages.gitlab.com/gitlab/gitlab-ee> for a list of available versions.

3. Compile the image:

   ```sh
   cd gitlab-arm64
   # Compile the CE version of GitLab
   docker build . \
      -t gitlab-ce:16.7.3-ce.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ce \
      --build-arg RELEASE_VERSION=16.7.3-ce.0
   # Compile the EE version of GitLab
   docker build . \
      -t gitlab-ee:16.7.3-ee.0 \
      --build-arg RELEASE_PACKAGE=gitlab-ee \
      --build-arg RELEASE_VERSION=16.7.3-ee.0
   ```

## Contributing

I welcome everyone in the community to contribute to this project! If you're working with ARM64 or x86-64 and run into any issues or have questions during deployment, please feel free to reach out. I am committed to assisting you and providing answers to the best of my ability.

I also invite you to submit pull requests. If you come across a problem that is specific to the ARM64 architecture (and not present in the official x86-64 version), your contributions are highly appreciated. By sharing your fixes and enhancements, you can help improve the project for all ARM64 users.

Let's work together to ensure the GitLab Docker image is as reliable and user-friendly as possible. Your input and contributions can make a significant difference!
