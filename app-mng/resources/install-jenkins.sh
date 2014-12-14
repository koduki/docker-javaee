#!/bin/bash

URL=http://pkg.jenkins-ci.org/redhat/jenkins-1.589-1.1.noarch.rpm

yum -y install ${URL}

sed /etc/sudoers 's/Defaults    requiretty/#Defaults    requiretty/g'
echo 'Defaults:jenkins !requiretty' >> /etc/sudoers
echo 'jenkins        ALL=(ALL)       NOPASSWD: ALL' >> /etc/sudoers
