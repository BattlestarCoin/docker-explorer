Battlestar Coin Explorer
========

This image is to run Battlestarcoin explorer.

Below is a docker compose stack, to make this work

On the Coin container, open /home/batl/.batl/batl.conf in the coin volume
 - add "rpcallowip=IPOFEXPLORERGOESHERE" < replace this with actual ip or subnet eg 172.*
 - take note of the rpcuser and rpcpassword
 
On the explorer container, open /home/iquidus/settings.json
 - in the wallet section add username and password from the rpcusername and password from the previous step

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
