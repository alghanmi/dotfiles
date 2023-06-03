# Known Hosts File

## GitHub
GitHub makes its SSH keys and host key fingerprints available via a [metadata endpoint](https://github.blog/changelog/2022-01-18-githubs-ssh-host-keys-are-now-published-in-the-api/). You can update the `known_hosts` file by running the following command:

```sh
curl --silent https://api.github.com/meta | jq --raw-output '"github.com "+.ssh_keys[]' > $HOME/.ssh/known_hosts.d/github.known_hosts
```

## BitBucket
BitBucket announces its [SSH Keys](https://bitbucket.org/blog/ssh-host-key-changes) in `known_hosts` format on their SSH endpoint:

```sh
curl --silent --output $HOME/.ssh/known_hosts.d/bitbucket.known_hosts https://bitbucket.org/site/ssh
```