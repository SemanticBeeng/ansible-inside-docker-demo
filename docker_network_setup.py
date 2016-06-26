# !/development/bin/python/anaconda3/bin/python python

import os
import subprocess
import sys

os.environ['DOCKER_PORT'] = "2400" 
os.environ['CONSUL_PORT'] = "8500"
os.environ['SWARM_CLUSTER_PORT'] = "2401"

def thisHostIP():
    return subprocess.check_output('hostname -i', shell=True).decode("utf-8") 

ip = thisHostIP()

print('This host IP address = ' + ip)
os.environ['THIS_HOST_IP'] = ip

## Get docker container IP address
# http://networkstatic.net/10-examples-of-how-to-get-docker-container-ip-address/
# https://forums.docker.com/t/how-to-get-a-full-id-of-a-certain-container/2418/2
# http://stackoverflow.com/a/34497614/4032515
# sudo docker ps -aqf "name=progrium/consul"

def cluster_KVserviceURL(consulPort) {

    consul_container_name = "progrium/consul"
    consul_id = subprocess.check_output("(docker ps | awk '{ print $1,$2 }' | grep " + consul_container_name + "| awk '{print $1 }'")

    #export CONSUL_ID=$(docker inspect --format="{{.Id}}" progrium/consul)

    consult_ip = subprocess.check_output("$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' " + consul_id)

    return "consul://" + consul_ip ":" + consultPort
}

