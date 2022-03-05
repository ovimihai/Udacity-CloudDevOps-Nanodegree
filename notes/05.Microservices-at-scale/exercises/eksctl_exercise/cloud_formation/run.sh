

#aws cloudformation deploy \
#    --template-file cluster.yml \
#    --stack-name eksctl-eksctl-demo-cluster


aws cloudformation deploy \
    --template-file node-group.yml \
    --stack-name eksctl-eksctl-demo-nodegroup-ng-7f9854c3
