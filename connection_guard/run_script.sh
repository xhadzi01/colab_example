#!/bin/bash

echo Running container: connection_guard_cont

docker run -it --rm --name connection_guard_cont connection_guard
