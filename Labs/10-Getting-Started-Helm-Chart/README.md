![](../../resources/terraform-logos.png)

![Visitor Badge](https://visitor-badge.laobi.icu/badge?page_id=nirgeier)

---

<!-- omit from toc -->
# Terraform Hands-on Repository

- A collection of Hands-on labs for Terraform.
- Each lab is a standalone lab and does not require to complete the previous labs.

---

![](../../resources/lab.jpg)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/TerraformLabs)

<!-- omit from toc -->
### **<kbd>CTRL</kbd> + click to open in new window**

<!-- inPage TOC start -->

---
<!-- omit from toc -->
## Lab Highlights:
 - [01. Getting started](#01-Getting-started)
   - [01.01. Create `main.tf`](#0101-Create-maintf)
 - [02. Adding terraform code](#02-Adding-terraform-code)
   - [02.01. Add provider `kubernetes`](#0201-Add-provider-kubernetes)
   - [02.02. Add provider `helm`](#0202-Add-provider-helm)
   - [02.03. Add namespace](#0203-Add-namespace)
   - [02.04. Add the helm chart resource](#0204-Add-the-helm-chart-resource)
 - [03. Run terraform](#03-Run-terraform)
   - [03.01. terraform init](#0301-terraform-init)
   - [03.02. terraform validate](#0302-terraform-validate)
   - [03.04. terraform plan](#0304-terraform-plan)
   - [03.03. terraform apply](#0303-terraform-apply)
 - [04. Verify that all resources have been created](#04-Verify-that-all-resources-have-been-created)
 - [05. Cleanup](#05-Cleanup)

---

<!-- inPage TOC end -->

### Preface

- In this tutorial we will be learning how can we user terraform to deploy helm chart ito our cluster.

### 01. Getting started

- For this part we will be using minikube & Helm
- If you don't have minikube installed, got back to the [first lab](../00-Setup).
- Start minikube: `minikube start --driver=virtualbox`
- In this lab we will learn how to work with Helm chart

### 01.01. Create `main.tf`

- As mentioned previously, in Terraform we usually define a file names `main.tf` as our root module file.
- Create `main.tf`

```hcl
# Create the working directory for our first module
mkdir codewizard-helm

# Switch to the demo directory
cd codewizard-helm

# Create the main terraform file
touch main.rf
```

### 02. Adding terraform code

- As we know in order to work with terraform we need to use providers.
- In this lab we will be using `Kubernetes` along with `Helm` as our providers
- Lets add write the providers in our `main.tf`

### 02.01. Add provider `kubernetes`

- Add the `kubernetes` provider with the following code:

  ```hcl
  # Add the kubernetes provider
  provider "kubernetes" {
    # Set the minikbue context
    # Tell Terraform that we are running our cluster under Minikube.
    config_context_cluster = "minikube"

    # Set the path to the kubeconfig
    config_path = "~/.kube/config"
  }
  ```

### 02.02. Add provider `helm`

- Add the `helm` provider with the following code:
  ```hcl
  provider "helm" {
    kubernetes {
      config_path = "~/.kube/config"
    }
  }
  ```

### 02.03. Add namespace

- Add the desired namespace resource

  ```hcl
  resource "kubernetes_namespace" "namespace_codewizard" {

    # Set the metadata of the namespace
    metadata {
      # Set the desired namespace name
      name = "codewizard"
    }
  }
  ```

### 02.04. Add the helm chart resource

- Once we have configured the helm provider we need to add the helm chart
- In terraform we will add a resource names `helm_release`
- Add the following code to the `main.tf`

  ```hcl
  resource "helm_release" "local_helm"{
    # The name of the chart
    name  = "codewizard-helm"

    # The path to the helm chart
    chart = "./codewizard-helm"
  }
  ```

---

## 03. Run terraform

### 03.01. terraform init

```hcl
$ terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "helm" (hashicorp/helm) 2.1.1...

...

* provider.helm: version = "~> 2.1"
* provider.kubernetes: version = "~> 2.1"

...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
```

### 03.02. terraform validate

- Lets validate that our tf files are valid
  ```hcl
  $ terraform validate
  Success! The configuration is valid.
  ```

### 03.04. terraform plan

```hcl
$ terraform plan

Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # helm_release.local_helm will be created
  + resource "helm_release" "local_helm" {
      + atomic                     = false
      + chart                      = "./codewizard-helm"
      + cleanup_on_fail            = false
      + create_namespace           = false
      + dependency_update          = false
      + disable_crd_hooks          = false
      + disable_openapi_validation = false
      + disable_webhooks           = false
      + force_update               = false
      + id                         = (known after apply)
      + lint                       = false
      + manifest                   = (known after apply)
      + max_history                = 0
      + metadata                   = (known after apply)
      + name                       = "codewizard-helm"
      + namespace                  = "codewizard"
      + recreate_pods              = false
      + render_subchart_notes      = true
      + replace                    = false
      + reset_values               = false
      + reuse_values               = false
      + skip_crds                  = false
      + status                     = "deployed"
      + timeout                    = 300
      + verify                     = false
      + version                    = "0.1.0"
      + wait                       = true
    }

  # kubernetes_namespace.namespace_codewizard will be created
  + resource "kubernetes_namespace" "namespace_codewizard" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "codewizard"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 2 to add, 0 to change, 0 to destroy.
```

### 03.03. terraform apply

- Lets skip 'terraform plan` since terraform will run terraform whenever we run terraform apply
- In order to skip the approval we will add the `-auto-approve` flag the apply command

  ```hcl
  $ terraform apply -auto-approve

  kubernetes_namespace.namespace_codewizard: Creating...
  kubernetes_namespace.namespace_codewizard: Creation complete after 0s [id=codewizard]
  helm_release.local_helm: Creating...
  helm_release.local_helm: Creation complete after 2s [id=codewizard-helm]

  Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
  ```

### 04. Verify that all resources have been created

- Lets verify that the terraform created the resources:

  ```sh
  kubectl get all -n codewizard

  NAME                                   READY          STATUS        RESTARTS            AGE
  pod/codewizard-helm-5585fdc585-pj4cg   1/1            Running       0                   80s

  NAME                      TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
  service/codewizard-helm   ClusterIP   10.100.63.188   <none>        80/TCP              80s

  NAME                                  READY           UP-TO-DATE    AVAILABLE           AGE
  deployment.apps/codewizard-helm       1/1             1             1                   80s

  NAME                                                  DESIRED       CURRENT     READY   AGE
  replicaset.apps/codewizard-helm-5585fdc585            1             1           1       80s
  ```

### 05. Cleanup

- Delete all the created resources
  ```hcl
  terraform destroy -auto-approve
  ```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../09-Getting-Started-Kubernetes">09-Getting-Started-Kubernetes</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../11.01-AWS-S3-Backend">11.01-AWS-S3-Backend</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->