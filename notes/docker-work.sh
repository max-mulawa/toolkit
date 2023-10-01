docker run --rm -it image sh
docker run --rm -it image /usr/bin/env bash


# remove stopped containers
docker ps -a | awk '{print $1}' | grep -v "CONT" | xargs docker rm -f

# refresh local docker images from registry
docker images | awk '{print $1 ":" $2}' | grep 'azurecr' | grep -v none | xargs -I {} docker pull {}

# docker dns updates to /etc/hosts
sudo ./docker-update-hosts.sh --address 127.0.0.1 --hosts /etc/hosts --verbose

# copy local file to container
docker cp /usr/bin/netstat postgresql:/usr/bin
