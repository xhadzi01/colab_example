#!/bin/bash

#-----------------------------------------------------------------------#
#                                                                       #
#  Builds docker image which will be used for anonymous connection      #
#  to Google Colab. It allows for change of mac address and IP address  #
#  so that we wont get easily stopped.                                  #
#                                                                       #
#-----------------------------------------------------------------------#

# process arguments, if not provided use default values for testing
if [[ "$1" == "" ]]; then
    SET_MAC="12:34:de:b0:6b:61"
fi

if [[ "$2" == "" ]]; then
    SET_IP="83.240.40.68"
fi

echo Building image: connection_guard
echo arguments:
echo    SET_MAC=$SET_MAC
echo    SET_IP=$SET_IP # unused yet

# we will be using kind of a hack here, sice we cant assign MAC address to docker build,
# but we can assign MAC to container and ther inherit from it

if [[ "$(docker images -q mac_workaround 2> /dev/null)" == "" ]]; then
    if [[ ! "$(docker ps -a -q -f status=exited -f name=mac_workaround)" ]]; then
        # if it is not exited, we will atempt to stop it first
        echo stopping old mac_workaround
        docker stop mac_workaround > /dev/null
    fi
    # removal not needed since it is already done by --rm flag
    #docker rm mac_workaround
fi
echo running mac_workaround to obtain new mac address
# running it as background proc
docker run --rm --name mac_workaround --mac-address=$SET_MAC -d alpine tail -f /dev/null > /dev/null

echo init build of connection_guard
docker build -t connection_guard --network container:mac_workaround --no-cache .
