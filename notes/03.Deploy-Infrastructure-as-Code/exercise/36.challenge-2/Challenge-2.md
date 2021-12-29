# Challenge 2

## Project Overview

You have been tasked with creating the required Infrastructure-as-code scripts for a new cloud environment in AWS. The _Lead Solutions Architect_ for the project sends you the following diagram.

![](https://video.udacity-data.com/topher/2021/February/602bb312_screenshot-2021-02-16-at-5.24.30-pm/screenshot-2021-02-16-at-5.24.30-pm.png)

## ToDo

Write a CloudFormation script that:

1. Creates a VPC
  * It will accept the IP Range -also known as CIDR block- from an input parameter

1. Creates and attaches an Internet Gateway to the VPC

1. Creates Two Subnets within the VPC with Name Tags to call them "Public" and "Private"
  * These will also need input parameters for their ranges, just like the VPC.

1. The Subnet called "Public" needs to have a NAT Gateway deployed in it
  * This will require you to allocate an Elastic IP that you can then use to assign it to the NAT Gateway.

1. The Public Subnet needs to have the MapPublicIpOnLaunch property set to true. Use this [reference](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-subnet.html#cfn-ec2-subnet-mappubliciponlaunch) for help.

1. The Private Subnet needs to have the MapPublicIpOnLaunch property set to false.

1. Both subnets need to be /24 in size.
  * If you need assistance with IP math, you can use a subnet calculator such as [this one](https://network00.com/NetworkTools/IPv4AddressPlanner/).

1. You will need 2 Routing Tables, one named Public and the other one Private

1. Assign the Public and Private Subnets to their corresponding Routing table

1. Create a Route in the Public Route Table to send default traffic ( 0.0.0.0/0 ) to the Internet Gateway you created

1. Create a Route in the Private Route Table to send default traffic ( 0.0.0.0/0 ) to the NAT Gateway

1. Finally, once you execute this CloudFormation script, you should be able to delete it and create it again, over and over in a predictable and repeatable manner, this is the true verification of working Infrastructure-as-Code

## Helpful hints:

1. The numbers in the diagram below show the recommended sequence for resource creation. This is not required by CloudFormation but it helps to keep you on track and allows you to stop and verify as you go.

![](https://video.udacity-data.com/topher/2021/February/602bb337_screenshot-2021-02-16-at-5.25.20-pm/screenshot-2021-02-16-at-5.25.20-pm.png)

Create the resources in the order highlighted above

![](https://video.udacity-data.com/topher/2021/February/602bb814_screenshot-2021-02-16-at-5.22.04-pm/screenshot-2021-02-16-at-5.22.04-pm.png)

To help you get running, the snapshot above  
shows the **Resources** that you would want to create.

1. Because NAT Gateways and Internet Gateway attachments aren't automatic and take some time to provision, you may need the DependsOn attribute to wait for these events in your script.

This NAT Gateway example shows the use of "DependsOn" to wait for an Attachment to complete:

[https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-natgateway.html](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-natgateway.html)

1. Finally: _Divide and Conquer!_ For example: just write the script for the VPC and Internet Gateway and make sure it works, then move on to adding more resources, increasing complexity as you go.  
  
**Tip: Don't attempt to write it all at once!**

## Expected Output

The stack details should show you the list of resources created successfully:

![](https://video.udacity-data.com/topher/2021/February/602bb697_screenshot-2021-02-16-at-5.40.38-pm/screenshot-2021-02-16-at-5.40.38-pm.png)

![](https://video.udacity-data.com/topher/2021/February/602bb706_screenshot-2021-02-16-at-5.40.51-pm/screenshot-2021-02-16-at-5.40.51-pm.png)

Newly created resources under the stack _challenge2_

### Solution

> Delete the stack, and recreate the same for the next challenge coming your way!

#### Supporting Materials

* [challenge2-solution.yml](https://video.udacity-data.com/topher/2021/February/602bb590_challenge2-solution/challenge2-solution.yml)
* [challenge2-solution-parameters.json](https://video.udacity-data.com/topher/2021/February/602bb5b6_challenge2-solution-parameters/challenge2-solution-parameters.json)