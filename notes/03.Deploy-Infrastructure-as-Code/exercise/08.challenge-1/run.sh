

aws cloudformation create-stack  --stack-name myFirstTest --region us-west-2 --template-body file://challenge.yaml

ssh -i ~\.ssh\aws-udacity-cdopsnd.pem ec2-user@ec2-54-200-113-157.us-west-2.compute.amazonaws.com