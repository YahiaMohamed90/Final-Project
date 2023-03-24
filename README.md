# **Final-Project**
 Description :- Devops project that fully automated build infrastructure and configure jenkins pipeline server using ansible configuration managemnt as a code then deploy flask app with mysql database as statefulset on kubernetes service on AWS then trigger changes that commeited on github repo to rebuild a new pipeline that deploy latest verision .....
#
# Project Stack & Technologies & Tools : Docker / Docker-compose / Terraform /Ansible / Jenkins / AWS / EKS / Nginx / ECR / Python 

 # How to build this project ::

 # clone the repo 
   - git clone https://github.com/YahiaMohamed90/Final-Project.git

 - you should have Terraform and Ansibal installed on your own system 
 
 -cd to infrastructure directory . run following commands
 
 # terraform init
 # terraform plan --var-file dv.tfvars
 # terraform apply --var-file dv.tfvars
 
 - after run above commands cheack your AWS Acount to validate infrastructure that were be created . ( Ec2 Jenkins Server & EKS cluster with Node Groups & ECR 

- After build infrastructure we are ready to deploy Flask-app with MYSQL database on kubernets cluster EKS

- to trigger the pipeline with github used # ngrok that expose jenkins localhost to can be using the url in github webhook

- ngrok download link https://ngrok.com/download


 # **important notice** 
 - in local.tf file you shouid replace # yahia by your home user name 
 - when creating EKS Cluster if you have issues when apply terraform file called worker.tf just run # apply again to create workernode
 - in provider.tf file you shouild replace yahia by your home user name
 - cd to public-ecr directory and run terraform apply to publish public repo



