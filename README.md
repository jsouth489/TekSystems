# README.md

##Steps to Run This Terraform Script:
Install Terraform:
##Ensure Terraform is installed on your local machine. You can download it from the Terraform website.
##Save the above Terraform script to a file named main.tf.

##Initialize Terraform:
##Open a terminal in the directory containing main.tf and run:
    terraform init
This command initializes the directory and downloads the necessary providers.

##Deploy the Infrastructure:
##Run the following command to create the infrastructure:
    terraform apply
Terraform will show you an execution plan and ask for confirmation. Type yes to proceed.

##Access the Web Server:
##Once the deployment is complete, Terraform will output the public IP address of the EC2 instance. You can access the web server by entering this IP address in your web browser.


##Destroy the Infrastructure:
    To clean up and remove all resources created by Terraform, run:
##terraform destroy
##Confirm with yes when prompted.



##Running the Dockerfile with Limited Container Permissions


##Steps to Run the Dockerfile:
##Save the Dockerfile:
##Save the provided Dockerfile content into a file named Dockerfile.

##Build the Docker Image:
##Open your terminal and navigate to the directory containing the Dockerfile.
##Run the following command to build the Docker image:
    docker build -t secure-container-image .
##This command builds an image named secure-container-image using the Dockerfile in the current directory.

##Run the Docker Container:
##After the image is built, you can run the container using:
    docker run --name secure-container-instance secure-container-image
##This command starts a container named secure-container-instance from the secure-container-image. The container will run with the non-root user as specified in the Dockerfile.

##Verify the Running User:
##To ensure the container is running as the non-root user, you can use the following command:
    docker exec -it secure-container-instance whoami
##This should return the username of the non-root user (e.g., appuser).

##Running the Kubernetes Pod with SecurityContext Settings
##Steps to Apply the Kubernetes YAML Configuration:
    Save the YAML Configuration:
##Save the provided YAML content into a file named secure-pod.yaml.

##Apply the Configuration:
##Open your terminal and ensure you are connected to your Kubernetes cluster.
##Run the following command to apply the configuration:
    kubectl apply -f secure-pod.yaml
##This command deploys a pod named secure-pod in your Kubernetes cluster with the specified security settings.

##Verify the Pod Deployment:
##Check the status of the pod using:
    kubectl get pods
##This will list all the pods, including secure-pod, and show whether it is running.

##Inspect the Pod’s SecurityContext:
##To inspect the security context applied to the pod, use:
    kubectl describe pod secure-pod
##This will display detailed information about the pod, including the securityContext settings, such as the user ID, group ID, and filesystem settings.







# Jenkins CI/CD Pipeline for Sample Application

##This repository contains a Jenkinsfile that defines a CI/CD pipeline for building, testing, and deploying a sample application to AWS. The pipeline includes security scanning and hardening steps to ensure the application's integrity and security.

## Prerequisites

- Jenkins installed and configured.
- Jenkins credentials for AWS (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY) and Docker registry access.
- A sample application repository in GitHub (or any other version control system).
- AWS CLI configured in the Jenkins environment.
- Docker installed on the Jenkins agent.

## Pipeline Stages

### 1. **Checkout Code**

- This stage clones the repository containing the sample application code.

### 2. **Build**

- Builds a Docker image for the sample application using the Dockerfile present in the repository.

### 3. **Security Scanning & Hardening**

- **Security Scanning**: This stage uses Trivy to scan the Docker image for vulnerabilities with high severity. The pipeline fails if any high-severity vulnerabilities are found.
- **Hardening**: Ensures the Docker image is not running as the root user. The pipeline fails if the image is configured to run as root.

### 4. **Test**

- Runs the application's test suite within the Docker container.

### 5. **Deploy to AWS**

- Logs into AWS Elastic Container Registry (ECR) and pushes the built Docker image.
- Deploys the image to AWS Elastic Container Service (ECS) or any other service as per the configuration.

## Running the Pipeline

### 1. **Configure Jenkins**

- **Credentials**: Add AWS credentials (AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY) to Jenkins.
- **GitHub Repository**: Ensure the GitHub repository URL is correct in the Jenkinsfile.

### 2. **Trigger the Pipeline**

- You can manually trigger the pipeline or configure it to run automatically on code commits using Jenkins' webhooks or polling.

### 3. **Monitor the Pipeline**

- Jenkins will execute the pipeline, displaying logs for each stage.
- If the pipeline encounters issues during the security scanning or hardening stage, it will fail, and you will need to address the identified vulnerabilities.

### 4. **Deployment**

- If all stages succeed, the application will be deployed to AWS using ECS or another specified service.

### Notes

- Modify the AWS region, ECR repository URL, and ECS service details as per your environment.
- Ensure that the `run_tests.sh` script or equivalent is available in your repository for the testing stage.
- Customize security scanning tools or hardening steps based on your requirements.

## Additional Information

- **Trivy**: An open-source tool for scanning containers for vulnerabilities. [Trivy GitHub](https://github.com/aquasecurity/trivy)
- **AWS ECS**: A highly scalable container orchestration service. [AWS ECS Documentation](https://aws.amazon.com/ecs/)
