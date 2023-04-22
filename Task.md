### K8S & Terraform

  **The expected answer for this question**:
  1. The tf file(s)
  2. A script which will execute the terraform code along with the command which you used to test that the deployment and the service are working as expected.
   
  #### 1. Create K8S cluster
  - Create **any** K8S cluster 
    - If you are working on google console you can use minikube - simply by running the command (**minikube start**)
    - You can also use any other K8S cluster for those task (Rancher, K3S, Kind etc)

  #### 2. Terraform 
  -  Write a Terraform code which will contain the following components:
  
      | Component     | Description                                                                                           |
      | ------------- | ----------------------------------------------------------------------------------------------------- |
      | Variable file | Define input variables as required above, you can also add your own variables if you wish             |
      | Namespace     | Namespace named "exam" (namespace should be set as input variable)                                    |
      | Deployment    | Deploy nginx container (any version) [https://hub.docker.com/_/nginx](https://hub.docker.com/_/nginx) |
      | Service       | port/target port should be defined as terraform `list` variable                                       |

  -  Add ability to change the image version using the variable file
  -  Create a service for the above deployment/pod
  -  Verify that that the container is working

  #### 3. Terraform and K8S 
  - Deploy the resources to K8S cluster
  - Verify that that the namespace exist
  - Verify that your Container is running.
  

<h1>Good Luck</h1>