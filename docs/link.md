`gcr-node link`
====================

It announces VRF and Voting Link transactions to the network for each node with 'Peer' or 'Voting' roles. This command finalizes the node registration to an existing network.

* [`gcr-node link`](#gcr-node-link)

## `gcr-node link`

It announces VRF and Voting Link transactions to the network for each node with 'Peer' or 'Voting' roles. This command finalizes the node registration to an existing network.

```
USAGE
  $ gcr-node link

OPTIONS
  -h, --help              It shows the help of this command.
  -t, --target=target     [default: target] The target folder where the gcr-node network is generated
  -u, --url=url           [default: http://localhost:3000] the network url

  --maxFee=maxFee         the max fee used when announcing (absolute). The node min multiplier will be used if it is not
                          provided.

  --noPassword            When provided, Bootstrap will not use a password, so private keys will be stored in plain
                          text. Use with caution.

  --password=password     A password used to encrypt and decrypt private keys in preset files like addresses.yml and
                          preset.yml. Bootstrap prompts for a password by default, can be provided in the command line
                          (--password=XXXX) or disabled in the command line (--noPassword).

  --ready                 If --ready is provided, the command will not ask for confirmation when announcing
                          transactions.

  --unlink                Perform "Unlink" transactions unlinking the voting and VRF keys from the node signer account

  --useKnownRestGateways  Use the best NEM node available when announcing. Otherwise the command will use the node
                          provided by the --url parameter.

EXAMPLES
  $ gcr-node link
  $ echo "$MY_ENV_VAR_PASSWORD" | gcr-node link --unlink --useKnownRestGateways
```

_See code: [src/commands/link.ts](https://github.com/goldcoinreserve/gcr-node/blob/v1.0.4/src/commands/link.ts)_
