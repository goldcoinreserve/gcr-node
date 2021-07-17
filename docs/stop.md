`gcr-node stop`
====================

It stops the docker-compose network if running (gcr-node started with --detached). This is just a wrapper for the `docker-compose down` bash call.

* [`gcr-node stop`](#gcr-node-stop)

## `gcr-node stop`

It stops the docker-compose network if running (gcr-node started with --detached). This is just a wrapper for the `docker-compose down` bash call.

```
USAGE
  $ gcr-node stop

OPTIONS
  -h, --help           It shows the help of this command.
  -t, --target=target  [default: target] The target folder where the gcr-node network is generated

EXAMPLE
  $ gcr-node stop
```

_See code: [src/commands/stop.ts](https://github.com/goldcoinreserve/gcr-node/blob/v1.0.4/src/commands/stop.ts)_
