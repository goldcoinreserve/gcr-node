`gcr-node config`
======================

Command used to set up the configuration files and the nemesis block for the current network

* [`gcr-node config`](#gcr-node-config)

## `gcr-node config`

Command used to set up the configuration files and the nemesis block for the current network

```
USAGE
  $ gcr-node config

OPTIONS
  -a, --assembly=assembly                   An optional assembly type, example "dual" for testnet

  -c, --customPreset=customPreset           External preset file. Values in this file will override the provided presets
                                            (optional)

  -h, --help                                It shows the help of this command.

  -p, --preset=(bootstrap|testnet|mainnet)  [default: bootstrap] the network preset

  -r, --reset                               It resets the configuration generating a new one

  -t, --target=target                       [default: target] The target folder where the gcr-node network is
                                            generated

  -u, --user=user                           [default: current] User used to run docker images when creating
                                            configuration files like certificates or nemesis block. "current" means the
                                            current user.

  --noPassword                              When provided, Bootstrap will not use a password, so private keys will be
                                            stored in plain text. Use with caution.

  --password=password                       A password used to encrypt and decrypt private keys in preset files like
                                            addresses.yml and preset.yml. Bootstrap prompts for a password by default,
                                            can be provided in the command line (--password=XXXX) or disabled in the
                                            command line (--noPassword).

  --pullImages                              It pulls the utility images from DockerHub when running the configuration.
                                            It only affects alpha/dev docker images.

  --report                                  It generates reStructuredText (.rst) reports describing the configuration of
                                            each node.

  --upgrade                                 It regenerates the configuration reusing the previous keys. Use this flag
                                            when upgrading the version of bootstrap to keep your node up to date without
                                            dropping the local data. The original preset (-t), assembly (-a), and custom
                                            preset (-a) must be used. Backup the target folder before upgrading.

EXAMPLES
  $ gcr-node config -p bootstrap
  $ gcr-node config -p testnet -a dual --password 1234
  $ echo "$MY_ENV_VAR_PASSWORD" | gcr-node config -p testnet -a dual
```

_See code: [src/commands/config.ts](https://github.com/goldcoinreserve/gcr-node/blob/v1.0.4/src/commands/config.ts)_
