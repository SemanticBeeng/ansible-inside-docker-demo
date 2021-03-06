# Source 
# https://github.com/SemanticBeeng/ansible_playbook/blob/master/Dockerfile
#
FROM phusion/baseimage:0.9.18

RUN apt-get update && \
    apt-get install -y \
	libffi-dev \
        libssl-dev \ 
        libsystemd-journal-dev \
        libapparmor-dev \
        python \
        python-dev \
        python-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install --upgrade setuptools pip
RUN pip install 'docker-py>=1.7.0'

RUN pip install ansible
RUN ansible-galaxy install \
    ANXS.hostname \
    ANXS.apt \
    ANXS.build-essential \
    ANXS.perl \
    ANXS.monit \
    ANXS.nginx

# 
ADD site.yml           /srv/ansible/site.yml

#RUN hostname devopscontrol

ENV ANSIBLE_GATHERING smart
ENV ANSIBLE_HOST_KEY_CHECKING false
ENV ANSIBLE_RETRY_FILES_ENABLED false
ENV ANSIBLE_ROLES_PATH /ansible/playbooks/roles
ENV ANSIBLE_SSH_PIPELINING True
ENV PATH /ansible/bin:$PATH
ENV PYTHONPATH /ansible/lib

CMD ["/sbin/my_init"]

