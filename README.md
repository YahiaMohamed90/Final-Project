# Final-Project
Description :- Devops project that fully automated build infrastructure and configure jenkins pipeline server using ansible configuration managemnt as a code the deploy flask app with mysql database as statefulset on kubernetes service on AWS then trigger changes that commeited on github repo to rebuild a new pipeline that deploy latest verision .....

Project Stack & Technologies & Tools : Docker / Docker-compose / Terraform /Ansible / Jenkins / AWS / EKS 

How to build this project ::

clone the repo :: git clone https://github.com/YahiaMohamed90/Final-Project.git

 you should have Terraform and Ansibal installed on your own system 
 
 cd to jenkins-ansible directory . run following commands
 
 # terraform init
 # terraform plan --var-file dv.tfvars
 # terraform apply --var-file dv.tfvars
 
 after run above commands cheack your AWS Acount to validate infrastructure that were be created . ( Ec2 Jenkins Server & EKS cluster with Node Groups & ECR 

After build infrastructure we are ready to deploy Flask-app with MYSQL database on kubernets cluster EKS

to trigger the pipeline with github used # ngrok that expose jenkins localhost to can be using the url in githb webhook

ngrok download link https://ngrok.com/download


