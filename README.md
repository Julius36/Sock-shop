## Prerequisites

Before you start, ensure you have the following tools installed on your local machine:
Terraform, Docker, Kubernetes CLI, Helm, AWS CLI, Prometheus, Grafana
## 1. Set Up AWS Environment

. **Configure AWS CLI:**
   -aws configure
   Provide your AWS Access Key ID, Secret Access Key, region, and output format when prompted.

## 2. Infrastructure Provisioning with Terraform
 The configuration defines a new VPC in which to provision the cluster, and uses the public EKS module to create the required resources, including Auto Scaling Groups, security groups, and IAM Roles and Policies.
 **Initialize the Terraform configuration:**
   terraform init
 **Plan the Terraform deployment:**
   terraform plan
   ![main tf - learn-terraform-provision-eks-cluster - Visual Studio Code 8_16_2024 8_04_12 AM](https://github.com/user-attachments/assets/32082739-00b8-4515-ad23-2d41a345be7c)

 **Apply the Terraform configuration to provision AWS resources:**
    terraform apply
   ![main tf - learn-terraform-provision-eks-cluster - Visual Studio Code 8_16_2024 8_05_14 AM](https://github.com/user-attachments/assets/150254f4-5a3
   ![main tf - learn-terraform-provision-eks-cluster - Visual Studio Code 8_16_2024 8_42_47 AM](https://github.com/user-attachments/assets/008246a8-5da8-4eba-b6e0-62d3f2ba6375)
   ![capstone-eks-oN5QO8Oc _ Clusters _ Elastic Kubernetes Service _ us-east-1 - Google Chrome 8_16_2024 8_46_50 AM](https://github.com/user-attachments/assets/656655a6-cc32-47e3-9f43-eedc8511c591)
![capstone-eks-oN5QO8Oc _ Clusters _ Elastic Kubernetes Service _ us-east-1 - Google Chrome 8_16_2024 8_50_07 AM](https://github.com/user-attachments/assets/3ee590d7-8ec2-4829-be5c-eace8260bf53)
e-4857-b2ef-3ab2094096db)

   This step will create the necessary infrastructure on AWS, including VPC, subnets, security groups, and an EKS cluster.

## 3. Deploy Kubernetes Cluster

 **Update kubeconfig to use your new EKS cluster:**
   aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
   
 **Verify the Kubernetes cluster is accessible:**
   kubectl get nodes
 ![main tf - learn-terraform-provision-eks-cluster - Visual Studio Code 8_16_2024 9_01_20 AM](https://github.com/user-attachments/assets/094f0a14-2ef0-44dc-987a-24fcd20aed5e)

## 4. Deploy Sock Shop Using Manifest file
   kubectl apply -f manifests
   kubectl get svc -n sock-shop
![Screenshot 8_16_2024 9_09_18 AM](https://github.com/user-attachments/assets/1d167984-1340-45b9-a2c0-46973b14e134)
![Screenshot 8_16_2024 9_09_08 AM](https://github.com/user-attachments/assets/886505ec-1d30-4069-b13f-52bcfe6ae60b)
![WeaveSocks - Google Chrome 8_14_2024 5_56_34 AM](https://github.com/user-attachments/assets/3c22f811-9134-43ba-8577-cc8605c69f23)
![WeaveSocks - Google Chrome 8_14_2024 5_56_38 AM](https://github.com/user-attachments/assets/0cf8052a-5aac-4a19-b276-cb1cacb97348)

## 6. Set Up Monitoring with Prometheus and Grafana
  kubectl apply -f manifests-monitoring
![main tf - learn-terraform-provision-eks-cluster - Visual Studio Code 8_16_2024 9_13_23 AM](https://github.com/user-attachments/assets/9d0ed215-4bf2-46b9-92ef-2169d4e61a26)
![main tf - learn-terraform-provision-eks-cluster - Visual Studio Code 8_16_2024 9_13_29 AM](https://github.com/user-attachments/assets/5131f4af-a2e0-44d8-97e5-66f9110d28aa)

kubectl port-forward service/prometheus 9090:9090 -n monitoring
![Prometheus Time Series Collection and Processing Server - Google Chrome 8_8_2024 1_07_51 AM](https://github.com/user-attachments/assets/9b27cf3c-b421-4378-a229-c0d690d8eb2f)
![Prometheus Time Series Collection and Processing Server - Google Chrome 8_16_2024 9_23_18 AM](https://github.com/user-attachments/assets/7ba19810-fb5f-4f72-ac56-c6a9e9584cdc)

kubectl port-forward service/grafana 9100:80 -n monitoring
![Grafana - Google Chrome 8_14_2024 6_36_05 AM](https://github.com/user-attachments/assets/a7c5ca7a-9e20-43b5-8ab8-6956cb8ac97e)
![127 0 0 1 - Google Chrome 8_14_2024 6_39_43 AM](https://github.com/user-attachments/assets/94fe3ee6-8041-4e6a-a1ac-e6faca30c7c7)

7. **Continuous Integration**
 ![Kubernetes Pods (Prometheus) - Grafana - Google Chrome 8_16_2024 10_04_31 AM](https://github.com/user-attachments/assets/85675ceb-e725-4c8b-a2dd-9a757ace1eb0)
![Kubernetes Pods (Prometheus) - Grafana - Google Chrome 8_16_2024 10_05_45 AM](https://github.com/user-attachments/assets/15c12c3b-5734-4aa1-8609-7085b0fab48d)
![Kubernetes Pods (Prometheus) - Grafana - Google Chrome 8_16_2024 10_06_05 AM](https://github.com/user-attachments/assets/fd52198c-10c7-49ac-8863-9e4feb3214f3)


8. **Delete the EKS cluster and all associated resources:**
   terraform destroy


