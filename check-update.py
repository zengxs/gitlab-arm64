#!/usr/bin/env python3
#
# Check the latest available version of gitlab package, and compare it with the
# current version.
#
# If the current version is older, then change the value of RELEASE_VERSION and
# PUSH_TAGS in build.yml to the latest version, and set github action output
# "update" to version number.

import os
import re
import sys
from pathlib import Path

try:
    import requests
    import semver
except ImportError as e:
    print("Error: " + str(e))
    print("Please install the required libraries using the following command:")
    print("pip3 install requests semver")
    exit(1)

BASE_DIR = Path(__file__).resolve().parent
BUILD_YML_PATH = BASE_DIR / ".github/workflows/build.yml"


def main():
    current_version = get_current_version()
    # Default to '18.0' if GITHUB_REF_NAME not set
    branch = os.getenv('GITHUB_REF_NAME', '18.0').split("/")[-1]
    latest_version = get_latest_version(branch)

    if semver.compare(current_version, latest_version) < 0:
        print(
            f'Current version "{current_version}" is older than latest version "{latest_version}"'
        )
        update_build_yml(latest_version)
        action_set_output("new_version", latest_version)
    else:
        print("Current version is up to date")


def get_current_version():
    # read build.yml
    build_yml = BUILD_YML_PATH.read_text()

    # extract RELEASE_VERSION from build.yml
    current_version = None
    for line in build_yml.splitlines():
        if "RELEASE_VERSION:" in line and "-ce.0" in line:
            current_version = line.split("RELEASE_VERSION:")[1].strip()
            break
    
    if not current_version:
        raise ValueError("Could not find CE version in build.yml")

    # remove -ce.0 suffix for version comparison
    current_version = current_version.replace("-ce.0", "")
    return current_version


def get_latest_version(branch):
    r = requests.get(
        "https://hub.docker.com/v2/namespaces/gitlab/repositories/gitlab-ce/tags?page_size=100",
        headers={
            "Accept": "application/json",
            "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:99.0) Gecko/20100101 Firefox/99.0",  # avoid anti-bot detection
        },
        timeout=30,
    )
    results = r.json()["results"]
    # Extract versions and filter for CE tags
    versions = []
    for result in results:
        name = result["name"]
        if not name.endswith("-ce.0"):
            continue
        # Remove -ce.0 suffix for semver parsing
        version = name.replace("-ce.0", "")
        versions.append(version)

    print(f"Filtering versions for branch {branch}")
    # filter out non-semver versions and match branch format (e.g. 17.5.*)
    filtered_versions = []
    branch_parts = branch.split('.')
    for version in versions:
        try:
            v = semver.VersionInfo.parse(version)
            print(f"Checking version {version} against branch {branch_parts[0]}.{branch_parts[1]}")
            if str(v.major) == branch_parts[0] and str(v.minor) == branch_parts[1]:
                filtered_versions.append(version)
                print(f"Found matching version: {version}")
        except (ValueError, IndexError):
            continue

    if not filtered_versions:
        raise ValueError(f"No valid versions found for branch {branch}")

    # sort versions and get the latest one
    filtered_versions = sorted(filtered_versions, key=semver.VersionInfo.parse, reverse=True)
    latest_version = filtered_versions[0]
    print(f"Selected latest version: {latest_version}")

    return latest_version


def update_build_yml(latest_version):
    # replace RELEASE_VERSION line
    build_yml = BUILD_YML_PATH.read_text()
    build_yml = re.sub(
        r"RELEASE_VERSION: \d+\.\d+\.\d+-ce\.0",
        f"RELEASE_VERSION: {latest_version}-ce.0",
        build_yml,
    )
    build_yml = re.sub(
        r"RELEASE_VERSION: \d+\.\d+\.\d+-ee\.0",
        f"RELEASE_VERSION: {latest_version}-ee.0",
        build_yml,
    )
    BUILD_YML_PATH.write_text(build_yml)

    # replace PUSH_TAGS line
    ver = semver.VersionInfo.parse(latest_version)
    build_yml = BUILD_YML_PATH.read_text()
    build_yml = re.sub(
        r"PUSH_TAGS: .*",
        f"PUSH_TAGS: {latest_version}-ce.0,{latest_version}-ce,{ver.major}.{ver.minor}-ce",
        build_yml,
    )
    BUILD_YML_PATH.write_text(build_yml)


def action_set_output(name, value):
    print("GitHub Actions: set output: " + name + "=" + value)

    if "GITHUB_OUTPUT" in os.environ:
        # See:
        # - https://docs.github.com/en/actions/using-workflows/workflow-commands-for-github-actions#setting-an-output-parameter
        # - https://stackoverflow.com/a/74444094
        with open(os.environ["GITHUB_OUTPUT"], "a") as f:
            f.write(f"{name}={value}\n")
    else:
        print("GITHUB_OUTPUT not set, skipping", file=sys.stderr)


if __name__ == "__main__":
    main()
