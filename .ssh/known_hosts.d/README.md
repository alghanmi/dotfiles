# Known Hosts File

## GitHub
GitHub makes its SSH keys and host key fingerprints available via a [metadata endpoint](https://github.blog/changelog/2022-01-18-githubs-ssh-host-keys-are-now-published-in-the-api/). You can update the `known_hosts` file by running the following command:

```sh
curl --silent https://api.github.com/meta | jq --raw-output '"github.com "+.ssh_keys[]' > $HOME/.ssh/known_hosts.d/github.com_known_hosts
```

## BitBucket
BitBucket announces its [SSH Keys](https://bitbucket.org/blog/ssh-host-key-changes) in `known_hosts` format on their SSH endpoint:

```sh
curl --silent --output $HOME/.ssh/known_hosts.d/bitbucket.org_known_hosts https://bitbucket.org/site/ssh
```

## GitLab
GitLab host key fingerprints are available in their [SSH keys and authentication](https://docs.gitlab.com/user/gitlab_com/#ssh-known_hosts-entries) documentation.
