#!/bin/bash

export THIS_NODE_IP=$(hostname -i)
export SWARM_CLUSTER_PORT=2401
export DOCKER_PORT=2400
export CONSUL_PORT=8500

export consul_container_name="progrium/consul"

################################################
# Cluster : start Key-Value store

function cluster_StartKVStore() {

    docker run -d \
      -p "$CONSUL_PORT:$CONSUL_PORT" \
      -h "consul" \
      $consul_container_name -server -bootstrap
}


################################################
# Cluster : get Key-Value store url
#
# Resources:
# http://networkstatic.net/10-examples-of-how-to-get-docker-container-ip-address/
# https://forums.docker.com/t/how-to-get-a-full-id-of-a-certain-container/2418/2
# http://stackoverflow.com/a/34497614/4032515
# sudo docker ps -aqf "name=progrium/consul"

function cluster_KVserviceURL() {

    local consul_id=$(docker ps | awk '{ print $1,$2 }' | grep $consul_container_name | awk '{print $1 }')

    #export CONSUL_ID=$(docker inspect --format="{{.Id}}" progrium/consul)

    local consul_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $consul_id)

    echo "consul://$consul_ip:$CONSUL_PORT"
}

################################################
# Cluster : start Docker engine

function cluster_StartDocker() {

#    sudo docker daemon -D -H $DOCKER_HOST --cluster-store=$(cluster_KVserviceURL)
     sudo docker daemon -D \
	-H $DOCKER_HOST \
	--cluster-store=$(cluster_KVserviceURL) \
        --cluster-advertise eth1:$DOCKER_PORT 
#       --cluster-store-opt kv.cacertfile=/path/to/ca.pem \
#       --cluster-store-opt kv.certfile=/path/to/cert.pem \
#       --cluster-store-opt kv.keyfile=/path/to/key.pem	

}


################################################
# Cluster : start manager

function cluster_StartManager() {

    local url=$(cluster_KVserviceURL)
    echo "Starting cluster manager on url " $url
    docker run --rm swarm manage $url/bigdata

    # Good option 2
    # docker run --rm swarm manage -H tcp://localhost:$SWARM_CLUSTER_PORT     $CONSUL_URL/bigdata

    # Bad option: "bind: cannot assign requested address"
    # docker run --rm swarm manage -H tcp://$THIS_NODE_IP:$SWARM_CLUSTER_PORT $CONSUL_URL/bigdata
}

################################################
# Cluster : advertise / join

function cluster_JoinNode() {

    local url=$(cluster_KVserviceURL)
    echo "Joining cluster on url " $url

    #CLUSTER_ADVERTISE="cluster-advertise=eth1:$SWARM_CLUSTER_PORT"

    docker run --rm swarm join --advertise=$THIS_NODE_IP:$SWARM_CLUSTER_PORT $url/bigdata
}




