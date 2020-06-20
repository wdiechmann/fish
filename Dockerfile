# BUILD STAGE
FROM bitwalker/alpine-elixir-phoenix:latest AS phx-builder

ARG mix_env=prod
ARG hex_mirror_url=https://repo.hex.pm

ENV NODE_ENV=${mix_env} \
  MIX_ENV=${mix_env} \
  APP_PORT=5000 \
  POOL_SIZE=10 \
  COOL_TEXT='tjuhej' \
  SECRET_KEY_BASE=dyhnmj9oklo0ok7y64332w2excvbhnkmlæ.æ-æp098uuikuygyhgfdw2123esdr5tghy78uhjki \
  DBUSER='xxx' \
  DBPWRD='xxx' \
  DBNAME='fish_prod' \
  DBHOST="xxx" \
  URLHOST='xxx' \
  HEX_MIRROR_URL=${hex_mirror_url} 

WORKDIR /app

COPY . .
RUN mix do deps.get, deps.compile
RUN npm install --prefix assets && \
  npm rebuild node-sass --prefix assets && \
  npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

RUN npm run --prefix ./assets deploy
RUN mix phx.digest
RUN mix do compile, release

RUN chown -R nobody:nobody /app
USER nobody:nobody

CMD ["/app/_build/prod/rel/fish/bin/fish", "start"]
