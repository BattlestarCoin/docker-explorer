Battlestar Coin Explorer
========

Below is a docker compose stack to run a Battlestarcoin explorer.


You need to set the environment variables

RPCUSER - eg 23l1k323lk123

PRCPASS - eg tlgdvf03l2k43

RPCIP - eg 172.56.1.*

You can also change the json in IQUIDUS_SETTINGS to update the config in the explorer, but if the key you change contains an object, you must supply a full replacement object.

IQUIDUS_SETTINGS must be valid json with no spaces before and after the : or comma.  If it is not, it will be ignored and the default config used.

Once the explorer has been set up, you can remove then enviroment varaibles if you wish, or if you wish to change the configs at any time you can just edit the settings.


## docker-compose.yml

```yaml
version: '2'
services:
  mongo:
    image: mongo:4.2-bionic
    networks: 
      - internal
    expose:
      - 27017
    restart: always
    volumes:
      - mongo:/data/db
  coin:
    image: battlestarcoin/linux-node
    environment:
      - RPCUSER=${RPCUSER}
      - PRCPASS=${PRCPASS}
      - RPCIP=${RPCIP}
    restart: always
    networks:
      - bridge
      - internal
    ports:
      - 16914:16914
    expose:
      - 59332
    volumes:
      - coin:/home/batl/
    command: ["batld", "-txindex=1"]
  explorer:
    image: battlestarcoin/explorer
    environment:
      - IQUIDUS_SETTINGS={"title":"BattlestarCoin Explorer","address":"https://explorer.domainhere.org","wallet":{"host":"coin","port":16915,"username":"${RPCUSER}","password":"${PRCPASS}"}}
    restart: unless-stopped
    networks:
      - bridge
      - internal
    ports:
      - 3001:3001
    volumes:
      - explorer:/home/iquidus
    depends_on:
      - mongo
      - coin
volumes:
  mongo:
    name: mongo
    driver: local
  coin:
    name: coin
    driver: local
  explorer:
    name: explorer
    driver: local

```
