pipeline {
    agent any

    environment {
        // Define environment variables, if necessary
        AWS_ACCESS_KEY_ID = credentials('aws-access-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('aws-secret-access-key')
        REGION = 'us-west-2'  // Replace with your preferred AWS region
    }

    stages {
        stage('Build') {
            steps {
                echo 'Building the application...'
                // Replace with your actual build commands
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                echo 'Running tests...'
                // Replace with your actual test commands
                sh 'mvn test'
            }
        }

        stage('Security Scan & Hardening') {
            steps {
                echo 'Running security scans and hardening...'
                // Example of running a security scan, replace with your tool of choice (e.g., OWASP ZAP, Snyk, Trivy)
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
                
                echo 'Applying security hardening...'
                // Example of security hardening steps, replace with your actual hardening process
                sh '''
                # Example hardening steps
                chmod -R go-w /path/to/your/application
                find /path/to/your/application -type f -exec chmod 644 {} \;
                find /path/to/your/application -type d -exec chmod 755 {} \;
                '''
            }
        }

        stage('Deploy to AWS') {
            steps {
                echo 'Deploying the application to AWS...'
                // Replace with your actual deployment commands
                withAWS(region: "${env.REGION}", credentials: 'aws-credentials') {
                    sh '''
                    aws s3 cp target/your-application.jar s3://your-bucket-name/
                    # You could add commands to deploy to an EC2 instance, ECS, etc.
                    '''
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up workspace...'
            cleanWs()
        }

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
            mail to: 'dev-team@example.com',
                 subject: "Jenkins Build Failed: ${env.JOB_NAME} ${env.BUILD_NUMBER}",
                 body: "Please check the build logs at ${env.BUILD_URL} for more details."
        }
    }
}

