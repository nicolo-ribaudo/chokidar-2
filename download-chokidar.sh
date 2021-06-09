#!/bin/sh

set -e

CHOKIDAR_VERSION=2.1.8

rm -rf chokidar
mkdir chokidar

npm pack "chokidar@$CHOKIDAR_VERSION"
tar zxvfC chokidar-$CHOKIDAR_VERSION.tgz chokidar --strip 1 package

rm chokidar-$CHOKIDAR_VERSION.tgz

node -e "
    const pkg = require('./package.json');
    pkg.dependencies = {
        ...require('./chokidar/package.json').dependencies,
        'glob-parent': '^5.1.2'
    };
    fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2) + '\n');
"
