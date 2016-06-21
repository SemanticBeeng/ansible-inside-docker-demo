#cwd=/development/projects/01_devops/docker/ansible-inside-docker-demo/config

docker run -it \
    -v /vagrant/hosts:$(pwd)/hosts \
    -v /vagrant/insecure_private_key:$(pwd)/insecure_private_key \
    synergo/ansible-examples:0.1 \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    bash
#    ansible-playbook /srv/ansible/site.yml \
#    -i $(pwd)/hosts -u vagrant --private-key=$(pwd)/insecure_private_key


