#!/bin/bash

echo Building image: connection_guard


# we will be using kind of a hack here, sice we cant assign MAC address to docker build,
# but we can assign MAC to container and then inherit from it. This is done to conceal our MAC address from connected to services.
# TODO: Create automated way to generate MACs.
docker run --rm --name mac_workaround --mac-address="12:34:de:b0:6b:61" -d alpine tail -f /dev/null
docker build -t connection_guard --network container:mac_workaround --no-cache .
