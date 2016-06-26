
## Get docker container IP address
# http://networkstatic.net/10-examples-of-how-to-get-docker-container-ip-address/
# https://forums.docker.com/t/how-to-get-a-full-id-of-a-certain-container/2418/2
# http://stackoverflow.com/a/34497614/4032515
# sudo docker ps -aqf "name=progrium/consul"

export consul_container_name=progrium/consul
export CONSUL_ID=$(docker ps | awk '{ print $1,$2 }' | grep $consul_container_name | awk '{print $1 }')

#export CONSUL_ID=$(docker inspect --format="{{.Id}}" progrium/consul)

export CONSUL_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $CONSUL_ID)

# 

export THIS_NODE_IP=$(hostname -i)
export SWARM_CLUSTER_PORT=2401
export DOCKER_PORT=2400
export CONSUL_PORT=8500

export CONSUL_URL="consul://$CONSUL_IP:$CONSUL_PORT"

export CLUSTER_KV_STORE="cluster-store=$CONSUL_URL"
export CLUSTER_ADVERTISE="cluster-advertise=eth1:$SWARM_CLUSTER_PORT"

################################################
# Swarm : start manager

# Good option 1
# docker run --rm swarm manage $CONSUL_URL/bigdata

# Good option 2
# docker run --rm swarm manage -H tcp://localhost:$SWARM_CLUSTER_PORT     $CONSUL_URL/bigdata

# Bad option
# docker run --rm swarm manage -H tcp://$THIS_NODE_IP:$SWARM_CLUSTER_PORT $CONSUL_URL/bigdata

################################################
# Swarm : advertise / join

# docker run --rm swarm join --advertise=$THIS_NODE_IP:$SWARM_CLUSTER_PORT $CONSUL_URL/bigdata




