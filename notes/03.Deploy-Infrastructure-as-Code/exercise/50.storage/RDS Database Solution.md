#### Create RDS database
In order to create a database in CloudFormation, you'll need 
* A Subnet group created, a Security Group that will control access in and out of your database.
* A user name and a password that will serve as the master for this db server. These should be the parameters in your script.
* You'll also need subnets, ideally 2.


#### Best Practice
* Add DeletionPolicy and set it to Retain at the bottom of your DB Creation script. This way you don't lose your database if you accidentally delete your stack.
*(Keep this in mind if you indeed intend to delete this DB when done practicing)*


```bash
aws cloudformation create-stack  --stack-name RDSstack --region us-west-2 --template-body file://RDSTemplate.yml --parameters file://RDSparameters.json --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" 
```
Don't forget to change the region, security groups, and subnet IDs as applicable to you. 
