export cwd=$(pwd)/config
export mnt=/home/vagrant

docker run -it \
    -v $cwd/hosts:$mnt/hosts \
    -v $cwd/ansible_id_rsa:$mnt/insecure_private_key \
    -v $(pwd)/ansible:$mnt/ansible \
    synergo/ansible-examples:0.1 \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    bash
#    ansible-playbook /srv/ansible/site.yml \
#    -i $(pwd)/hosts -u vagrant --private-key=$(cwd)/insecure_private_key


