`gcr-node enrollRewardProgram`
======================================

It enrols the nodes in the rewards program by announcing the enroll transaction to the registration address.  You can also use this command to update the program registration when you change the agent keys (changing the agent-ca-csr) or server host.

Currently, the only program that can be enrolled post-launch is 'SuperNode'.

* [`gcr-node enrollRewardProgram`](#gcr-node-enrollrewardprogram)

## `gcr-node enrollRewardProgram`

It enrols the nodes in the rewards program by announcing the enroll transaction to the registration address.  You can also use this command to update the program registration when you change the agent keys (changing the agent-ca-csr) or server host.

```
USAGE
  $ gcr-node enrollRewardProgram

OPTIONS
  -c, --customPreset=customPreset  This command uses the encrypted addresses.yml to resolve the main private key. If the
                                   main private is only stored in the custom preset, you can provide it using this
                                   param. Otherwise, the command may ask for it when required.

  -h, --help                       It shows the help of this command.

  -t, --target=target              [default: target] The target folder where the gcr-node network is generated

  -u, --url=url                    [default: http://localhost:3000] the network url

  --maxFee=maxFee                  the max fee used when announcing (absolute). The node min multiplier will be used if
                                   it is not provided.

  --noPassword                     When provided, Bootstrap will not use a password, so private keys will be stored in
                                   plain text. Use with caution.

  --password=password              A password used to encrypt and decrypt private keys in preset files like
                                   addresses.yml and preset.yml. Bootstrap prompts for a password by default, can be
                                   provided in the command line (--password=XXXX) or disabled in the command line
                                   (--noPassword).

  --ready                          If --ready is provided, the command will not ask for confirmation when announcing
                                   transactions.

  --useKnownRestGateways           Use the best NEM node available when announcing. Otherwise the command will use the
                                   node provided by the --url parameter.

DESCRIPTION
  Currently, the only program that can be enrolled post-launch is 'SuperNode'.

EXAMPLES
  $ gcr-node enrollRewardProgram
  $ gcr-node enrollRewardProgram --noPassword
  $ gcr-node enrollRewardProgram --useKnownRestGateways
  $ gcr-node enrollRewardProgram --password 1234 --url http://external-rest:3000
  $ echo "$MY_ENV_VAR_PASSWORD" | gcr-node enrollRewardProgram --url http://external-rest:3000
```

