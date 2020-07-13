#!/bin/bash

#On error no such file entrypoint.sh, execute in terminal - dos2unix entrypoint.sh

### FRONT-END
npm config set cache /app/.npm-cache --global
npm install

rm entrypoint.sh