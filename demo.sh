#!/bin/bash
################################################
#this script will list all the resources in the aws account.
#Author:Kalasritha
#
#following are the supported AWS services by the script
#
#
#1.EC2
#2.S3
#3.vpc
#4.Cloudwatch
#5.IAM
#
#Usage:./demo.sh <region> <service_name>
#Example: ./demo.sh us-east-1 EC2
###############################################  

#check if the requrired number of arguments are passed
if [$# -ne 2]; then
	echo "Usage: ./demo.sh <aws_region> <aws_service>"
	echo"Example: ./demo.sh us-east-1 ec2"
	exit 1
fi

#assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$2

#check if the AWS CLI is installed
if ! command -v aws &>/dev/null; then
	echo "AWS CLI is not installed. Please install the AWS CLI and try 
	again."
	exit 1
fi

#list the resources based on the service

case $aws_service in
	ec2)
		echo "listing EC2 instances in $aws_region"
		aws ec2 describe-instances --region $aws_region
		;;
	s3)
		echo "Listing S3 Buckets in $aws_region"
		aws s3api list-buckets --region $aws_region
		;;
	vpc)
		echo "listing VPCs in $aws_region"
		aws ec2 describe-vpcs --region $aws_region
		;;
	cloudwatch)
		echo "listing Clodwatch Alarms in $aws_region"
		aws cloudwatch describe-alarms --region $aws_region
		;;
	iam)
		echo "listing IAM users in $aws_region"
		aws iam list-users --region $aws_region
		;;
	*)
		echo "invalid service.Please enter a valid service."
		exit 1
		;;
	esac
