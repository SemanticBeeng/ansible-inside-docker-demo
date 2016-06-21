cwd=/development/projects/01_devops/docker/ansible-inside-docker-demo

docker run -it \
    -v /vagrant/hosts:$cwd/hosts \
    -v /vagrant/insecure_private_key:$cwd/ansible_id_rsa \
    ansible-examples \
    /sbin/my_init --skip-startup-files --skip-runit -- \
    ansible-playbook /srv/ansible/site.yml \
    -i $cwd/hosts -u vagrant --private-key=$cwd/ansible_id_rsa

