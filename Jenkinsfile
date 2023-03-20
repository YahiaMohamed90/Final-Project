pipeline {
    agent any
    stages {
            
            stage('Docker Image Build') {
                steps {
                    sh 'docker build  .  -t final-project -f Flask-app/app/Dockerfile '
                }
            }
            stage('Push Docker Image to ECR') {
                steps {
                withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_KEY=${env.AWS_SECRET_KEY}", "REGION=${env.REGION}"]) {
                        sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 587246694710.dkr.ecr.us-west-2.amazonaws.com/myecr'
                        sh 'docker tag final-project:latest 587246694710.dkr.ecr.us-west-2.amazonaws.com/myecr/final-project:latest'
                        sh 'docker push 587246694710.dkr.ecr.us-west-2.amazonaws.com/myecr/final-project:latest'
                    }
                }
            }
            stage('Integrate Jenkins with EKS Cluster and Deploy') {
                steps {
                withEnv(["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_KEY=${env.AWS_SECRET_KEY}", "REGION=${env.REGION}"]) {
                        script {
                            sh 'aws eks update-kubeconfig --name eksclustername --region us-west-2'
                            sh 'kubectl create -f /eks-flask-files/configMap.yml '
                            sh 'kubectl create -f /eks-flask-files/secret.yml '
                            sh 'kubectl create -f /eks-flask-files/statefulset.yml '
                            sh 'kubectl create -f /eks-flask-files/flask-app.yml '
                            cleanWs deleteDirs: true
                          



                        }
                    }
                }
            }
    }
 }
