#!/bin/bash

# copy over rails assets from rails container where it was built to
# nginx container, so it can statically render it
#
# tried doing this with docker volumes, but that there's issues with cache
sudo docker cp `sudo docker ps -aqf "name=current_web"`:/app/public .
sudo docker cp public `sudo docker ps -aqf "name=nginx"`:/etc/nginx/public
