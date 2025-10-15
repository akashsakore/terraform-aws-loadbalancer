#!/bin/bash
set -e

echo "========================================="
echo "Updating system packages..."
echo "========================================="
sudo apt update -y && sudo apt upgrade -y

echo "========================================="
echo "Installing Java (required for Jenkins)..."
echo "========================================="
sudo apt install -y fontconfig openjdk-17-jre

echo "========================================="
echo "Adding Jenkins repository and key..."
echo "========================================="
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "========================================="
echo "Installing Jenkins..."
echo "========================================="
sudo apt update -y
sudo apt install -y jenkins

echo "========================================="
echo "Starting and enabling Jenkins service..."
echo "========================================="
sudo systemctl enable jenkins
sudo systemctl start jenkins

echo "========================================="
echo "Installing Terraform..."
echo "========================================="
TERRAFORM_VERSION=${TERRAFORM_VERSION}
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo apt install -y unzip
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
sudo mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo "========================================="
echo "Verifying installation..."
echo "========================================="
java -version
terraform -version
sudo systemctl status jenkins --no-pager

echo "========================================="
echo "Installation complete!"
echo "Jenkins running on: http://<EC2-Public-IP>:8080"
echo "To get admin password: sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
echo "========================================="

