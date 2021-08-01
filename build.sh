#!/bin/bash

#######################################
# Check if environment variable is set
# Arguments:
#   "$1" is environment variable name
# Outputs:
#   Do nothing if var is set,
#   else exit with code 1
#######################################
function require_var {
    if [ -z "${!1}" ]; then
        echo "Failed: require variable \"$1\""
        exit 1
    fi
}

#######################################
# Read json file and print the value of key
# Globals:
#   None
# Arguments:
#   "$1" is json file path
#   "$2" is key to read
# Outputs:
#   Writes the value of key to stdout
#######################################
function read_json {
python3 <<EOS
import json
with open("$1", "r") as f:
    data = json.load(f)
    print(data.get("$2", ""))
EOS
}

#######################################
# Generate RELEASE file
# Globals:
#   None
# Arguments:
#   "$1" is gitlab package, "gitlab-ce" or "gitlab-ee"
#   "$2" is gitlab version, (eg: "14.0.5-ce.0")
# Outputs:
#   Writes RELEASE file content to stdout
#######################################
function generate_release {
    echo "RELEASE_PACKAGE=$1"
    echo "RELEASE_VERSION=$2"
    echo 'DOWNLOAD_URL=https://packages.gitlab.com/gitlab/${RELEASE_PACKAGE}/packages/ubuntu/focal/${RELEASE_PACKAGE}_${RELEASE_VERSION}_arm64.deb/download.deb'
}

#######################################
# Push tag to docker registry
# Globals:
#   DRYRUN if set, skip docker operation
# Arguments:
#   "$1" is local image with tag
#   "$2" is remote image name with tag
#######################################
function docker_push {
    echo "==> Push \"$1\" to \"$2\""
    [ -z "$DRYRUN" ] && docker tag "$1" "$2"
    [ -z "$DRYRUN" ] && docker push "$2"
}


# if DRYRUN is set, skip docker operations (login, build and push)

DOCKERHUB_USERNAME=zengxs
# DOCKERHUB_TOKEN from environment variables

GHCR_USERNAME=zengxs
# GHCR_TOKEN from environment variables

if [ -z "$DRYRUN" ]; then
    require_var DOCKERHUB_TOKEN
    require_var GHCR_TOKEN
fi

PUSH_AS_LATEST=$(read_json release.json latest)
BRANCH=$(read_json release.json branch)

# build gitlab-ce
ce_version=$(read_json release.json version-ce)

echo "==> Generate RELEASE file for $ce_version"
generate_release gitlab-ce $ce_version > ./RELEASE

ce_tag="gitlab:$ce_version"
echo "==> Build docker image \"$ce_tag\""
[ -z "$DRYRUN" ] && docker build . -t "$ce_tag"


# build gitlab-ee
ee_version=$(read_json release.json version-ee)

echo "==> Generate RELEASE file for $ee_version"
generate_release gitlab-ee $ee_version > ./RELEASE

ee_tag="gitlab:$ee_version"
echo "==> Build docker image \"$ee_tag\""
[ -z "$DRYRUN" ] && docker build . -t "$ee_tag"


# push to docker hub
DOCKERHUB_IMAGE_NAME="$DOCKERHUB_USERNAME/gitlab"
echo "==> Login to DockerHub"
[ -z "$DRYRUN" ] && echo "$DOCKERHUB_TOKEN" | docker login --username "$DOCKERHUB_USERNAME" --password-stdin

docker_push "$ce_tag" "$DOCKERHUB_IMAGE_NAME:$ce_version"
docker_push "$ce_tag" "$DOCKERHUB_IMAGE_NAME:$BRANCH"
docker_push "$ce_tag" "$DOCKERHUB_IMAGE_NAME:$BRANCH-ce"
docker_push "$ee_tag" "$DOCKERHUB_IMAGE_NAME:$ee_version"
docker_push "$ee_tag" "$DOCKERHUB_IMAGE_NAME:$BRANCH-ee"

if [ ! -z "PUSH_AS_LATEST" ]; then
    echo "==> Push images to DockerHub as latest version"
    docker_push "$ce_tag" "$DOCKERHUB_IMAGE_NAME:ce"
    docker_push "$ee_tag" "$DOCKERHUB_IMAGE_NAME:ee"
    docker_push "$ce_tag" "$DOCKERHUB_IMAGE_NAME:latest"
fi


# push to ghcr.io
GHCR_IMAGE_NAME="ghcr.io/$GHCR_USERNAME/gitlab-arm"
echo "==> Login to ghcr.io"
[ -z "$DRYRUN" ] && echo "$GHCR_TOKEN" | docker login ghcr.io --username "$GHCR_USERNAME" --password-stdin

docker_push "$ce_tag" "$GHCR_IMAGE_NAME:$ce_version"
docker_push "$ce_tag" "$GHCR_IMAGE_NAME:$BRANCH-ce"
docker_push "$ce_tag" "$GHCR_IMAGE_NAME:$BRANCH"
docker_push "$ee_tag" "$GHCR_IMAGE_NAME:$ee_version"
docker_push "$ee_tag" "$GHCR_IMAGE_NAME:$BRANCH-ee"

if [ ! -z "PUSH_AS_LATEST" ]; then
    echo "==> Push images to ghcr.io as latest version"

    docker_push "$ce_tag" "$GHCR_IMAGE_NAME:ce"
    docker_push "$ee_tag" "$GHCR_IMAGE_NAME:ee"
    docker_push "$ce_tag" "$GHCR_IMAGE_NAME:latest"
fi
