pipeline {
    agent any
    stages {
            
            stage('Docker Image Build') {
                steps {
                    sh 'docker build  .  -t public-ecr -f Flask-app/app/Dockerfile '
                }
            }
            stage('Push Docker Image to ECR') {
                steps {
                withEnv(["AWS_ACCESS_KEY=${env.AWS_ACCESS_KEY}", "AWS_SECRET_KEY=${env.AWS_SECRET_KEY}", "REGION-ECR=${env.REGION-ECR}"]) {
                        sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/n4z8o9z9'
                        sh 'docker tag public-ecr:latest public.ecr.aws/n4z8o9z9/public-ecr:latest'
                        sh 'docker push public.ecr.aws/n4z8o9z9/public-ecr:latest'
                    }
                }
            }
            stage('Integrate Jenkins with EKS Cluster and Deploy') {
                steps {
                withEnv(["AWS_ACCESS_KEY=${env.AWS_ACCESS_KEY}", "AWS_SECRET_KEY=${env.AWS_SECRET_KEY}", "REGION=${env.REGION}"]) {
                        script {
                            sh 'aws eks update-kubeconfig --name my-EKS1 --region us-west-2'
                            sh 'kubectl create -f /eks-flask-files/configMap.yml '
                            sh 'kubectl create -f /eks-flask-files/secret.yml '
                            sh 'kubectl create -f /eks-flask-files/statefulset.yml '
                            sh 'kubectl create -f /eks-flask-files/flask-app.yml '
                           
                          



                        }
                    }
                }
            }
    }
 }

 }
