`gcr-node compose`
=======================

It generates the `docker-compose.yml` file from the configured network.

* [`gcr-node compose`](#gcr-node-compose)

## `gcr-node compose`

It generates the `docker-compose.yml` file from the configured network.

```
USAGE
  $ gcr-node compose

OPTIONS
  -h, --help           It shows the help of this command.
  -t, --target=target  [default: target] The target folder where the gcr-node network is generated

  -u, --user=user      [default: current] User used to run the services in the docker-compose.yml file. "current" means
                       the current user.

  --noPassword         When provided, Bootstrap will not use a password, so private keys will be stored in plain text.
                       Use with caution.

  --password=password  A password used to encrypt and decrypt private keys in preset files like addresses.yml and
                       preset.yml. Bootstrap prompts for a password by default, can be provided in the command line
                       (--password=XXXX) or disabled in the command line (--noPassword).

  --upgrade            It regenerates the docker compose and utility files from the <target>/docker folder

EXAMPLE
  $ gcr-node compose
```

_See code: [src/commands/compose.ts](https://github.com/goldcoinreserve/gcr-node/blob/v1.0.4/src/commands/compose.ts)_
