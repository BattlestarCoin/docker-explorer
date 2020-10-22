#!/bin/ash

CONFIG=/home/iquidus/settings.json

node -p "try{JSON.stringify({...require('$CONFIG'), ...JSON.parse(process.env.IQUIDUS_SETTINGS)}, null, 2)}catch(e){JSON.stringify({...require('$CONFIG')}, null, 2)}" > "${CONFIG}.tmp"
mv "${CONFIG}.tmp" "${CONFIG}"

exec "$@"