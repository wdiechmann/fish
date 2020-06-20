#!/bin/sh

# Remove old releases
rm -rf _build/prod/rel/*

# Build the image
docker build --rm -t fish2 -f Dockerfile .

# Run the container
# docker run -it --rm --name fish -v $(pwd)/_build/prod/rel:/opt/app/_build/prod/rel fish
