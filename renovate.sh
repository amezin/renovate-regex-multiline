#!/bin/bash

# https://docs.renovatebot.com/modules/platform/local/

# Run under 'sudo -g docker' if necessary
# TODO: podman

if [[ " $(groups) " =~ " docker " ]]; then
    docker_cmd=(docker)
else
    docker_cmd=(sudo -g docker docker)
fi

exec "${docker_cmd[@]}" \
    run \
    --user "$(id -u):$(id -g)" \
    --group-add root \
    --group-add docker \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --rm \
    -it \
    -v "$PWD:$PWD" \
    -w "$PWD" \
    -e "LOG_LEVEL=${LOG_LEVEL:-debug}" \
    ghcr.io/renovatebot/renovate:slim \
    --platform=local \
    "$@"
