# README.md
Running the Dockerfile with Limited Container Permissions


Steps to Run the Dockerfile:
Save the Dockerfile:

Save the provided Dockerfile content into a file named Dockerfile.
Build the Docker Image:

Open your terminal and navigate to the directory containing the Dockerfile.
Run the following command to build the Docker image:
docker build -t secure-container-image .
This command builds an image named secure-container-image using the Dockerfile in the current directory.

Run the Docker Container:
After the image is built, you can run the container using:
docker run --name secure-container-instance secure-container-image
This command starts a container named secure-container-instance from the secure-container-image. The container will run with the non-root user as specified in the Dockerfile.

Verify the Running User:
To ensure the container is running as the non-root user, you can use the following command:
docker exec -it secure-container-instance whoami
This should return the username of the non-root user (e.g., appuser).

Running the Kubernetes Pod with SecurityContext Settings
Steps to Apply the Kubernetes YAML Configuration:
Save the YAML Configuration:
Save the provided YAML content into a file named secure-pod.yaml.

Apply the Configuration:
Open your terminal and ensure you are connected to your Kubernetes cluster.
Run the following command to apply the configuration:
kubectl apply -f secure-pod.yaml
This command deploys a pod named secure-pod in your Kubernetes cluster with the specified security settings.

Verify the Pod Deployment:
Check the status of the pod using:
kubectl get pods
This will list all the pods, including secure-pod, and show whether it is running.

Inspect the Pod’s SecurityContext:
To inspect the security context applied to the pod, use:
kubectl describe pod secure-pod
This will display detailed information about the pod, including the securityContext settings, such as the user ID, group ID, and filesystem settings.




Steps to Run This Terraform Script:
Install Terraform:
Ensure Terraform is installed on your local machine. You can download it from the Terraform website.

Save the above Terraform script to a file named main.tf.
Initialize Terraform:

Open a terminal in the directory containing main.tf and run:

terraform init
This command initializes the directory and downloads the necessary providers.

Deploy the Infrastructure:
Run the following command to create the infrastructure:

terraform apply
Terraform will show you an execution plan and ask for confirmation. Type yes to proceed.

Access the Web Server:
Once the deployment is complete, Terraform will output the public IP address of the EC2 instance. You can access the web server by entering this IP address in your web browser.

Destroy the Infrastructure:
To clean up and remove all resources created by Terraform, run:

terraform destroy
Confirm with yes when prompted.
