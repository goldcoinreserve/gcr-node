# gcr-node

Tool that allows you creating, configuring and running gcr&#39;s complete networks or nodes to be sync with existing networks.


<!-- toc -->
* [gcr-node](#gcr-node)
* [Key benefits:](#key-benefits)
* [Concepts](#concepts)
* [Intro](#intro)
* [Requirements](#requirements)
* [Step-by-step](#step-by-step)
* [Usage](#usage)
* [Enabling harvesting](#enabling-harvesting)
* [E2E Testing support](#e2e-testing-support)
* [Development](#development)
* [Command Topics](#command-topics)
<!-- tocstop -->



# Key benefits:

-   It's an installable cli tool. It's not a repo you need to clone and compile.
-   The configuration is parametrized via CLI commands and presets instead of by changing properties files.
-   The tools code is unique for any type of network, new networks or nodes in a network. It doesn't need to be copied and pasted in different projects or assemblies.
-   The config command runs on the host machine, not via docker making it easier to debug or tune
-   It's uses the TS SDK for key generation, vrf transactions, address generation instead of using catapult-tools (nemgen is still used to generate the nemesis block).
-   Easier to maintain, the properties files are reused for all nodes, assemblies and network types.
-   Network setup (how many database, nodes, rest gateways to run) is defined in presets, users can provide their own ones.
-   Docker-compose yaml files are generated based on the network setup/preset instead of being manually created/upgraded.
-   The created network (config, nemesis and docker-compose) can be zipped and distributed for other host machines to run it.
-   The used docker images versions can be changed via configuration/preset
-   It uses the [oclif](https://oclif.io) framework. New commands are easy to add and document.
-   It can be included as a npm dependency for clients' e2e testing.

# Concepts

## Preset:

Yaml files that define the configuration and layout of the network and nodes. It defines how many nodes, database, rest gateways, the modes, keys, etc.

Presets are defined at 4 levels from general to specific:

-   Shared: Default configurations for all the networks.
-   Network: It defines the main preset of a given network, example: `bootstrap` or `testnet`.
-   Assembly: It defines a modification of a network, example: `testnet peer`, `tesnet dual`, `testnet api`. Assembly is required for some networks (like `testnet`).
-   Custom: A user provided yml file (`--customPreset` param) that could override some or all properties in the out-of-the-box presets.

Properties in each file override the previous values (by object deep merge).


### Custom preset:

It's the way you can tune the network without modifying the code. It's a yml file (`--customPreset` param) that could override some or all properties in the out-of-the-box presets.

Custom presets give gcr Bootstrap its versatility. Check out the custom preset [guides](docs/presetGuides.md)!

## Target:

The folder where the generated config, docker files and data are stored. The folder structure is:

-   `./preset.yml`: the final generated preset.yml that it's used to configure bootstrap, the nodes, docker, etc.
-   `./addresses.yml`: randomly generated data that wasn't provided in the preset. e.g.: SSL keys, nodes' keys, nemesis accounts, generation hash seed, etc.
-   `./nodes`: it holds the configuration, data and logs for all the defined node instances.
-   `./gateways`: it holds the configuration and logs for all the defined node rest gateways.
-   `./nemesis`: The folder used to hold the nemesis block. Block 1 data is generated via `nemgen` tool for new networks. For existing network, it is copied over.
-   `./databases`: the location where the mongo data is stored for the different database instances.
-   `./docker`: the generated docker-compose.yml, mongo init scripts and server basic bash scripts. 
-   `./reports`: the location of the generated reports.

# Intro

-   Tested well on Ubuntu 18.04 TLS
-   Don't run under root, run under power user:

```
adduser powerusername
usermod -aG sudo powerusername
su powerusername
cd
```

# Requirements

-   Node 10+
-   Docker
-   Docker Compose 1.29+ (better to use https://docs.docker.com/engine/install/ubuntu/)

# Step-by-step

You may need NVM to manage node version

```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
```

To use NVM, you may need to logout and login to your session
Install Node 12:

```
nvm install 12
nvm use 12
```

Get the latest version of docker and docker compose:

```
sudo curl -fsSL https://get.docker.com -o get-docker.sh 
sudo sh get-docker.sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo groupadd docker
sudo usermod -aG docker $USER
```

Validate your environment by running:

```
node -v
docker -v
docker-compose -v
```

Check your user can run docker without sudo:

```
docker run hello-world
```

If you see an error like:

```
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```

Try to logout and login, or please follow this [guide](https://www.digitalocean.com/community/questions/how-to-fix-docker-got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket).

Get gcr Node:

```
cd /home/powerusername
git clone https://github.com/goldcoinreserve/gcr-node.git
```

Install gcr node

```
cd gcr-node
npm i
npm install -g
cd ..
```
Logout and Login

# Usage

It's recommended to run the commands from en empty working dir.

The network configuration, data and docker files will be created inside the target folder ('./target') by default.

```
mkdir node
cd node
```

Create node custom name:

```
cd ~/node`
```

```
echo "nodes:
  -
    friendlyName: 'REPLACE_NODE_NAME_HERE'
" > name.yml
```

Once in the working dir:

<!-- usage -->
```sh-session
$ npm install -g @goldcoinreserve/gcr-node
$ gcr-node COMMAND
running command...
$ gcr-node (-v|--version|version)
@goldcoinreserve/gcr-node/1.0.4 win32-x64 node-v12.19.0
$ gcr-node --help [COMMAND]
USAGE
  $ gcr-node COMMAND
...
```
<!-- usagestop -->

The general usage would be:

```
gcr-node config -p mainnet -a dual --customPreset name.yml
gcr-node compose
gcr-node run -d
```

IMPORTANT: Please open 7900 and 3000 for communication with network

If you need to start fresh, you many need to sudo remove the target folder (docker volumes dirs may be created using sudo). Example:

```
sudo rm -rf ./target
```

# Enabling harvesting


gcr-node creates peer nodes with remote harvesting enabled by default, but they still need to be registered by announcing the AccountKeyLink and VrfKeyLink transactions to the network.

This can be done by gcr-node too, but it needs to be a step separated from gcr-node start because funds are required to announce transactions.

You can find the main address to fund in the file located at node/target/addresses.yml

To decrypt your private keys, you can use this command:

```
gcr-node decrypt --source target/addresses.yml --destination plain-addresses.yml
```

The decrypted file with your provate keys will be located at node/plain-addresses.yml


Once the node is running with gcr-node start and you have funded its account, from a different terminal (but from the same folder), simply type:

```
gcr-node link
```

In case the node can't find any node to transmit transaction, you may set an external URL:


```
gcr-node link --url=http://20.79.16.203:3000
```


# E2E Testing support

One use case of this CLI is client E2E testing support. If you are coding a gcr-node client, you (Travis or Jenkins) can run e2e tests like:

```
gcr-node start -p bootstrap --detached
YOUR TEST (e.g: npm run test, gradle test, selenium etc.)
gcr-node stop
```

`--detached` starts the server waiting until it is up (by polling the network http://localhost:3000/node/health). The command will fail if the components are not up in 30 seconds.

You can also provide your own custom preset (`-c`) if you want your e2e test to start with a specific state (specific balances addresses, mosaics, namespaces, generation hash seed, etc.)

## Node client E2E via CLI:

The CLI can also be used as npm project (dev) dependency (`npm install --save-dev gcr-node`). Then you can integrate the network to your npm test cycle.
Your `package.json` can look like this:

```yaml

"devDependencies": {
    ....
    "gcr-node": "0.0.x",
    ....
}

scripts": {
...
    "clean-network": "gcr-node clean",
    "run-network": "gcr-node start -c ./output/my_custom_preset.yml --detached --healthCheck",
    "run-stop": "gcr-node stop",
    "integration-test": "....some mocha/jest/etc tests running against localhost:3000 network....",
    "e2e": "npm run clean-network && npm run run-network && npm run integration-test && npm run stop-network",
...
}
```

Then, you, Jenkins, Travis or your CI tool can run;

```
npm run e2e
```

## Node client E2E via API:

Alternatively, you can use the [BootstrapService](https://github.com/goldcoinreserve/gcr-node/blob/main/src/service/BootstrapService.ts) facade to programmatically start and stop a server.

Example:

```ts
import {BootstrapService, StartParams, Preset} from 'gcr-node'; 
import {expect} from '@oclif/test'; 

it('Bootstrap e2e test', async () => {
    const service = new BootstrapService();
    const config: StartParams = {
        preset: Preset.bootstrap,
        reset: true,
        healthCheck: true,
        timeout: 60000 * 5,
        target: 'target/bootstrap-test',
        detached: true,
        user: 'current',
    };
    try {
        await service.stop(config);
        const configResult = await service.start(config);
        expect(configResult.presetData).not.null;
        expect(configResult.addresses).not.null;
        // Here you can write unit tests against a http://localhost:3000 network
    } finally {
        await service.stop(config);
    }
});
```

It's recommended to reuse the same server for multiple tests by using `beforeAll`, `afterAll` kind of statements.

# Development

If you want to contribute to this tool, clone this repo and run:

```
npm i
npm install -g
```

Then, `gcr-node` runs from the source code. You can now try your features after changing the code.

Pull Requests are appreciated! Please follow the contributing [guidelines](CONTRIBUTING.md).

Note: cloning this repo is only for people that want to tune the tool in a way it cannot be configured. If this is your case, please provide a feature request.
General users should install this tool like any other node module.



<!-- commands -->
# Command Topics

* [`gcr-node autocomplete`](docs/autocomplete.md) - display autocomplete installation instructions
* [`gcr-node clean`](docs/clean.md) - It removes the target folder deleting the generated configuration and data
* [`gcr-node compose`](docs/compose.md) - It generates the `docker-compose.yml` file from the configured network.
* [`gcr-node config`](docs/config.md) - Command used to set up the configuration files and the nemesis block for the current network
* [`gcr-node decrypt`](docs/decrypt.md) - It decrypts a yml file using the provided password. The source file can be a custom preset file, a preset.yml file or an addresses.yml.
* [`gcr-node encrypt`](docs/encrypt.md) - It encrypts a yml file using the provided password. The source files would be a custom preset file, a preset.yml file or an addresses.yml.
* [`gcr-node enrolRewardProgram`](docs/enrolRewardProgram.md) - It enrols the nodes in the rewards program by announcing the enrol transaction to the registration address.  You can also use this command to update the program registration when you change the node public key or server host.
* [`gcr-node healthCheck`](docs/healthCheck.md) - It checks if the services created with docker compose are up and running.
* [`gcr-node help`](docs/help.md) - display help for gcr-node
* [`gcr-node link`](docs/link.md) - It announces VRF and Voting Link transactions to the network for each node with 'Peer' or 'Voting' roles. This command finalizes the node registration to an existing network.
* [`gcr-node report`](docs/report.md) - it generates reStructuredText (.rst) reports describing the configuration of each node.
* [`gcr-node resetData`](docs/resetData.md) - It removes the data keeping the generated configuration, certificates, keys and block 1.
* [`gcr-node run`](docs/run.md) - It boots the network via docker using the generated `docker-compose.yml` file and configuration. The config and compose methods/commands need to be called before this method. This is just a wrapper for the `docker-compose up` bash call.
* [`gcr-node start`](docs/start.md) - Single command that aggregates config, compose and run in one line!
* [`gcr-node stop`](docs/stop.md) - It stops the docker-compose network if running (gcr-node started with --detached). This is just a wrapper for the `docker-compose down` bash call.

<!-- commandsstop -->
