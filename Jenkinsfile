pipeline {
    agent any
    stages {
        stage('Checkout') {
                steps {
                    checkout([$class: 'GitSCM', branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/YahiaMohamed90/Final-Project.git']]])
                }
            }
            stage('Docker Image Build') {
                steps {
                    sh 'docker build  -f /Flsk-app/app/Dockerfile -t final-provect '
                }
            }
            stage('Push Docker Image to ECR') {
                steps {
                    withAWS(credentials: 'aws-cred', region: 'us-west-2') {
                        sh 'aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 587246694710.dkr.ecr.us-west-2.amazonaws.com/myecr'
                        sh 'docker tag final-project:latest 587246694710.dkr.ecr.us-west-2.amazonaws.com/myecr/final-project:latest'
                        sh 'docker push 587246694710.dkr.ecr.us-west-2.amazonaws.com/myecr/final-project:latest'
                    }
                }
            }
            stage('Integrate Jenkins with EKS Cluster and Deploy') {
                steps {
                    withAWS(credentials: 'aws-cred', region: 'us-west-2') {
                        script {
                            sh 'aws eks update-kubeconfig --name eksclustername --region us-west-2'
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
