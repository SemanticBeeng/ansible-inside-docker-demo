export cwd=$(pwd)/config
export mnt=/var/opt

docker run -it \
    -h devopscontrol \
    -v $cwd/hosts:/etc/ansible/hosts \
    -v $cwd/ansible.cfg:/etc/ansible/ansible.cfg \
    -v $cwd/ansible_id_rsa:/root/.ssh/id_rsa \
    -v $cwd/ansible_id_rsa.pub:/root/.ssh/id_rsa.pub \
    -v $(pwd)/ansible:$mnt/ansible \
    synergo/ansible-examples:0.1 \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    bash
#    ansible-playbook /srv/ansible/site.yml \
#    -i $(pwd)/hosts -u vagrant --private-key=$(cwd)/insecure_private_key



