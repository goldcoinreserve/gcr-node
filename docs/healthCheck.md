`gcr-node healthCheck`
===========================

It checks if the services created with docker compose are up and running.

This command checks:
- Whether the docker containers are running.
- Whether the services' exposed ports are listening.
- Whether the rest gateways' /node/health are OK.

The health check process handles 'repeat' and custom 'openPort' services.

* [`gcr-node healthCheck`](#gcr-node-healthcheck)

## `gcr-node healthCheck`

It checks if the services created with docker compose are up and running.

```
USAGE
  $ gcr-node healthCheck

OPTIONS
  -h, --help           It shows the help of this command.
  -t, --target=target  [default: target] The target folder where the gcr-node network is generated

DESCRIPTION
  This command checks:
  - Whether the docker containers are running.
  - Whether the services' exposed ports are listening.
  - Whether the rest gateways' /node/health are OK.

  The health check process handles 'repeat' and custom 'openPort' services.

EXAMPLE
  $ gcr-node healthCheck
```

_See code: [src/commands/healthCheck.ts](https://github.com/goldcoinreserve/gcr-node/blob/v1.0.4/src/commands/healthCheck.ts)_
