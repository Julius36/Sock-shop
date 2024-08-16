## Prerequisites

Before you start, ensure you have the following tools installed on your local machine:
Terraform, Docker, Kubernetes CLI, Helm, AWS CLI, Prometheus, Grafana
## 1. Set Up AWS Environment

1. **Configure AWS CLI:**
   ```bash
   aws configure
   ```
   Provide your AWS Access Key ID, Secret Access Key, region, and output format when prompted.

## 2. Infrastructure Provisioning with Terraform
 The configuration defines a new VPC in which to provision the cluster, and uses the public EKS module to create the required resources, including Auto Scaling Groups, security groups, and IAM Roles and Policies.
1. **Initialize the Terraform configuration:**
   ```bash
   terraform init
   ```

2. **Plan the Terraform deployment:**
   ```bash
   terraform plan
   ```

3. **Apply the Terraform configuration to provision AWS resources:**
   ```bash
   terraform apply
   ```

   This step will create the necessary infrastructure on AWS, including VPC, subnets, security groups, and an EKS cluster.

## 3. Deploy Kubernetes Cluster

1. **Update kubeconfig to use your new EKS cluster:**
   ```bash
   aws eks --region <your-region> update-kubeconfig --name <your-cluster-name>
   ```

2. **Verify the Kubernetes cluster is accessible:**
   ```bash
   kubectl get nodes
   ```

3. **Create a namespace for the Sock Shop application:**
   ```bash
   kubectl create namespace sock-shop
   ```

## 4. Deploy Sock Shop Using Helm

1. **Add the Helm chart repository:**
   ```bash
   helm repo add sock-shop https://microservices-demo.github.io/helm-charts/
   helm repo update
   ```

2. **Install the Sock Shop chart:**
   ```bash
   helm install sock-shop sock-shop/sock-shop --namespace sock-shop
   ```

3. **Verify the deployment:**
   ```bash
   kubectl get pods -n sock-shop
   ```

## 5. Expose the Sock Shop Application

1. **Expose the Sock Shop service using a LoadBalancer:**
   ```bash
   kubectl expose deployment front-end --type=LoadBalancer --name=sock-shop --namespace=sock-shop
   ```

2. **Get the external IP:**
   ```bash
   kubectl get svc --namespace sock-shop
   ```
   Access the Sock Shop application via the external IP.

## 6. Set Up Monitoring with Prometheus and Grafana

1. **Deploy Prometheus using Helm:**
   ```bash
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   helm install prometheus prometheus-community/prometheus --namespace sock-shop
   ```

2. **Deploy Grafana using Helm:**
   ```bash
   helm install grafana prometheus-community/grafana --namespace sock-shop
   ```

3. **Access Grafana:**
   ```bash
   kubectl get svc --namespace sock-shop
   ```
   Use the external IP to access Grafana. The default login is `admin`/`admin`.

4. **Add Prometheus as a data source in Grafana:**
   - Go to Grafana's web UI.
   - Navigate to **Configuration** > **Data Sources** > **Add Data Source**.
   - Select **Prometheus** and enter the Prometheus server URL (`http://prometheus-server.sock-shop.svc.cluster.local`).

5. **Import Dashboards:**
   - Go to **Create** > **Import**.
   - Use Prometheus and Grafana official dashboards or custom ones for microservices monitoring.

## 7. Logging

1. **Set up logging using CloudWatch (Optional):**
   - Configure your Kubernetes cluster to send logs to AWS CloudWatch.
   - Install and configure the `aws-for-fluent-bit` DaemonSet.

2. **Install Fluent Bit:**
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/aws/aws-for-fluent-bit/mainline/deploy/kubernetes/fluent-bit.yaml
   ```

3. **Verify logs in CloudWatch:**
   - Go to the AWS Management Console.
   - Navigate to CloudWatch and check the logs for your EKS cluster.

## 8. Clean Up

To tear down the infrastructure and remove all resources created:

1. **Uninstall Helm charts:**
   ```bash
   helm uninstall sock-shop prometheus grafana --namespace sock-shop
   ```

2. **Delete the EKS cluster and all associated resources:**
   ```bash
   terraform destroy
   ```

## 9. References

- [Sock Shop GitHub Repository](https://github.com/microservices-demo/microservices-demo)
- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Helm Documentation](https://helm.sh/docs/)
- [Kubernetes Documentation](https://kubernetes.io/docs/)

---

Feel free to adapt this template to better suit your needs, add more details where necessary, and adjust any commands based on your specific environment or preferences.
