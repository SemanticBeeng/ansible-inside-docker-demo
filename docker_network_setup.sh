
## Get docker container IP address
# http://networkstatic.net/10-examples-of-how-to-get-docker-container-ip-address/
# https://forums.docker.com/t/how-to-get-a-full-id-of-a-certain-container/2418/2
# http://stackoverflow.com/a/34497614/4032515
# sudo docker ps -aqf "name=progrium/consul"

export consul_container_name=progrium/consul
export CONSUL_ID=$(docker ps | awk '{ print $1,$2 }' | grep $consul_container_name | awk '{print $1 }')

#export CONSUL_ID=$(docker inspect --format="{{.Id}}" progrium/consul)

export CONSUL_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONSUL_ID)

