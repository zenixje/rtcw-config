#!/bin/bash

input="${1}"; shift
output="${1}"; shift

# If an exploding barrel gibs a player, the server will crash.
# To remedy this we remove all exploding barrels.
if grep "props_flamebarrel" "${input}"; then
    bbe -e \
        's/props_flamebarrel/props_flamebar111/' \
        "${input}" > \
        "${output}"
fi
