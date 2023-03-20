# Final-Project
Description :- Devops project that fully automated build infrastructure and configure jenkins pipeline server using ansible configuration managemnt as a code the deploy flask app with mysql database as statefulset on kubernetes service on AWS then trigger changes that commeited on github repo to rebuild a new pipeline that deploy latest verision .....

Project Stack & Technologies & Tools : Docker / Docker-compose / Terraform /Ansible / Jenkins / AWS / EKS 

How to build this project ::

clone the repo :: git clone https://github.com/YahiaMohamed90/Final-Project.git

 you should have Terraform and Ansibal installed on your own system 
 
 cd to infrastructure directory . run following commands
 
 # terraform init
 # terraform plan --var-file dv.tfvars
 # terraform apply --var-file dv.tfvars
 
 after run above commands cheack your AWS Acount to validate infrastructure that were be created . ( Ec2 Jenkins Server & EKS cluster with Node Groups & ECR 

After build infrastructure we are ready to deploy Flask-app with MYSQL database on kubernets cluster EKS

to trigger the pipeline with github used # ngrok that expose jenkins localhost to can be using the url in githb webhook

ngrok download link https://ngrok.com/download


Requirements
Name	Version
terraform	>= 0.13.1
aws	>= 3.73
Providers
Name	Version
aws	4.34.0
Modules
Name	Source	Version
vpc	git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git	v3.16.0
Resources
Name	Type
aws_eks_cluster.this	resource
aws_eks_node_group.this	resource
aws_iam_role.eksClusterRole	resource
aws_iam_role.eksWorkerNodeRole	resource
aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly	resource
aws_iam_role_policy_attachment.AmazonEKSClusterPolicy	resource
aws_iam_role_policy_attachment.AmazonEKSVPCResourceController	resource
aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy	resource
aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy	resource
aws_region.current	data source
Inputs
Name	Description	Type	Default	Required
cluster_name	Name of the EKS Cluster. Must be between 1-100 characters in length. Must begin with an alphanumeric character, and must only contain alphanumeric characters, dashes and underscores (^[0-9A-Za-z][A-Za-z0-9-_]+$).	string	n/a	yes
desired_size	Desired size of the worker node, the default value is 2	number	2	no
instance_types	List of instance types associated with the EKS Node Group. the default vaule is ["t3.medium"]. Terraform will only perform drift detection if a configuration value is provided.	list(string)	
[
  "t3.medium"
]
no
max_size	Maximum size of the worker node, the default value is 2	number	2	no
min_size	Minimum size of the worker node, the default value is 1	number	1	no
vpc_cidr	The Cidr of VPC where cluster will be created on, the default value is "10.0.0.0/16"	string	"10.0.0.0/16"	no
vpc_name	Name of VPC where cluster will be created on	string	n/a	yes
Outputs
Name	Description
arn	EKS Cluster ARN
cert	Certificate authority
cluster_security_group_id	Cluster security group that was created by Amazon EKS for the cluster. Managed node groups use this security group for control-plane-to-data-plane communication.
host	Endpoint for your Kubernetes API server.
id	Name of the cluster.
identity	Attribute block containing identity provider information for your cluster
vpc_id	ID of the VPC associated with your cluster.

