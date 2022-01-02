

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

terraform --version

sudo yum install awscli -y
aws --version

# next run aws configure
# default region: eu-central-1
# default output: json