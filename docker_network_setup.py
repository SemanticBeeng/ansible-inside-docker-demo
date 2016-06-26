# !/development/bin/python/anaconda3/bin/python python

import os
import subprocess
import sys

os.environ['DOCKER_PORT'] = "2400" 
os.environ['CONSUL_PORT'] = "8500"
os.environ['SWARM_CLUSTER_PORT'] = "2401"

def thisHostIP():
    ip = subprocess.check_output('hostname -i', shell=True).decode("utf-8") 
    print('This host IP address = ' + ip)

    return ip

os.environ['THIS_HOST_IP'] = thisHostIP()
