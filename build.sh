#! /bin/bash

yum install -y wget

npm install

sh install-hugo.sh

cp -r node_modules/comlink static/javascripts/
cp -r node_modules/pinch-zoom-element/dist static/javascripts/pinch-zoom-element

mkdir data/
echo "Fetching Web Mentions"
node process-mentions.js "https://webmention.io/api/mentions.jf2?per-page=100&domain=paul.kinlan.me&token=$WEBMENTION"

echo "Building site"
./hugo -d dist

npx rollup -c rollup.config.js

echo "Sending mentions"
npx webmention dist/index.xml --limit 1 --send
