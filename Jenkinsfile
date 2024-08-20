pipeline {
    agent any

    environment {
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        DOCKER_IMAGE = "sample-app:latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-repo/sample-app.git'
            }
        }

        stage('Build') {
            steps {
                script {
                    docker.build("$DOCKER_IMAGE")
                }
            }
        }

        stage('Security Scanning & Hardening') {
            steps {
                script {
                    // Example using Trivy for scanning
                    sh 'trivy image --exit-code 1 --severity HIGH $DOCKER_IMAGE'

                    // Example hardening step - ensuring no root user
                    sh '''
                    docker inspect $DOCKER_IMAGE | grep -q '"User": ""' && exit 1 || exit 0
                    '''
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    docker.image("$DOCKER_IMAGE").inside {
                        sh './run_tests.sh'
                    }
                }
            }
        }

        stage('Deploy to AWS') {
            steps {
                withAWS(credentials: 'aws-credentials-id', region: 'us-west-2') {
                    script {
                        sh '''
                        # Login to ECR
                        $(aws ecr get-login --no-include-email --region us-west-2)
                        
                        # Tag and push the image
                        docker tag $DOCKER_IMAGE 123456789012.dkr.ecr.us-west-2.amazonaws.com/sample-app:latest
                        docker push 123456789012.dkr.ecr.us-west-2.amazonaws.com/sample-app:latest
                        
                        # Deploy using ECS (example)
                        aws ecs update-service --cluster my-cluster --service my-service --force-new-deployment
                        '''
                    }
                }
            }
        }
    }
}
