#!/bin/bash
#wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
#rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
# yum install jenkins -y --nogpgcheck -q
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
apt update -yqq
apt install default-jre default-jdk  wget git mc htop -yqq
sudo apt install jenkins -yqq
useradd -s /bin/bash jenkins
systemctl enable jenkins
sudo service jenkins start
#systemctl start jenkins
echo "Wait for secret"
while [ ! -f  /var/lib/jenkins/secrets/initialAdminPassword ]
do
    sleep 2
done
runuser -l jenkins -c 'echo -e "\n\n\n" | ssh-keygen -t rsa'
runuser -l jenkins -c 'cat ~/.ssh/id_rsa'
runuser -l jenkins -c 'cat ~/.ssh/id_rsa.pub'

echo "Secret here:"
cat /var/lib/jenkins/secrets/initialAdminPassword
