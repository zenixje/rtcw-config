#!/bin/bash

input="${1}"; shift
output="${1}"; shift

# If an exploding barrel gibs a player, the server will crash.
# To remedy this we remove all exploding barrels.

# We know ahead of time that most of the default maps do not contain barrels
# so let's not waste cycles on these.
default_maps_skip=(
    "mp_beach"
    "mp_castle"
    "mp_depot"
    "mp_destruction"
    "mp_sub"
    "mp_village"
    "mp_trenchtoast"
    "mp_keep"
    "mp_chateau"
    "mp_tram"
    "mp_dam"
    "mp_rocket"
)

map_name="${input%.bsp}"
map_name="${map_name##*/}"

for skip_map in "${default_maps_skip[@]}"; do
    if [ "${skip_map}" == "${map_name}" ]; then
        echo "Default map ${map_name} does not contain barrels, skipping..."
        exit 0
    fi
done

if grep "props_flamebarrel" "${input}"; then
    bbe -e \
        's/props_flamebarrel/props_flamebar111/' \
        "${input}" > \
        "${output}"
fi
