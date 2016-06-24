export cwd=$(pwd)/config
export mnt=/var/opt

docker run -it \
    -h devopscontrol \
    -v $cwd/hosts:/etc/ansible/hosts \
    -v $cwd/ansible.cfg:/etc/ansible/ansible.cfg \
    -v $cwd/ansible_id_rsa:/root/.ssh/id_rsa \
    -v $cwd/ansible_id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd)/ansible:$mnt/ansible \
    -w $mnt/ansible \
    -v /usr/bin/docker:/usr/bin/docker \
    -e DOCKER_HOST=$DOCKER_HOST \
    synergo/ansible-examples:0.1 \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    bash



