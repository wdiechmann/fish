#!/bin/sh

mix do deps.get, deps.compile
npm install --prefix assets && \
  npm rebuild node-sass --prefix assets && \
  npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

npm run --prefix ./assets deploy
mix phx.digest

NODE_ENV=prod \
  MIX_ENV=prod \
  APP_PORT=5000 \
  POOL_SIZE=10 \
  COOL_TEXT='tjuhej' \
  SECRET_KEY_BASE=æjkldsfgoiuqewtp9871324598p7lardgjkhndmnfalkjhdsfgoiusdr98765dfdde2sgdx \
  DBUSER='xxx' \
  DBPWRD='xxx' \
  DBNAME='fish_prod' \
  DBHOST="1.2.3.4" \
  URLHOST='localhost' \
mix do compile, release

NODE_ENV=prod \
  MIX_ENV=prod \
  APP_PORT=5000 \
  POOL_SIZE=10 \
  COOL_TEXT='tjuhej' \
  SECRET_KEY_BASE=æjkldsfgoiuqewtp9871324598p7lardgjkhndmnfalkjhdsfgoiusdr98765dfdde2sgdx \
  DBUSER='xxx' \
  DBPWRD='xxx' \
  DBNAME='fish_prod' \
  DBHOST="1.2.3.4" \
  URLHOST='localhost' \
_build/prod/rel/fish/bin/fish start