# Omnibus GitLab Docker for ARM64

> Upstream: <https://gitlab.com/gitlab-org/omnibus-gitlab/-/tree/master/docker> 


### Prebuilt versions
* `14.0.1-ce.0`
* `14.0.1-ee.0`
* `13.12.3-ee.0`

You can pull prebuilt docker image from ghcr.io:
```sh
docker pull ghcr.io/zengxs/gitlab-arm:<version>
```


### Differences compared to official dockerfile

* Add package `libatomic1` (gitlab require it)
* Change ssh port from `22` to `2222`
