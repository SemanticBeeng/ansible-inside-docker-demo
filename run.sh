cwd=/development/projects/01_devops/docker/ansible-inside-docker-demo/config

docker run -it \
    -v /vagrant/hosts:$cwd/hosts \
    -v /vagrant/insecure_private_key:$cwd/insecure_private_key \
    synergo/ansible-examples:0.1 \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    ansible-playbook /srv/ansible/site.yml \
    -i $cwd/hosts -u vagrant --private-key=$cwd/insecure_private_key


