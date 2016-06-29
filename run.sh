export docker_projects=/development/projects/01_devops/docker
export docker_prj=$docker_projects
export cwd=$cprj/config
export mnt=/var/opt

echo 'cwd' $cwd

docker run -it --rm \
    -h devopscontrol \
    -v $cwd/hosts:/etc/ansible/hosts \
    -v $cwd/ansible.cfg:/etc/ansible/ansible.cfg \
    -v $cwd/ansible_id_rsa:/root/.ssh/id_rsa \
    -v $cwd/ansible_id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $docker_prj/ansible-inside-docker-demo/ansible:$mnt/ansible \
    -v $docker_prj/ansible-inside-docker-demo:$mnt/ansible/projects \
    -v $docker_prj/../mantl:$mnt/mantl \
    -v /data:/data \
    -w $mnt/ansible \
    -v /usr/bin/docker:/usr/bin/docker \
    -v /var/lib/docker:/var/lib/docker \
    -e DOCKER_HOST=$DOCKER_HOST \
    synergo/ansible-examples:0.1 \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    bash



