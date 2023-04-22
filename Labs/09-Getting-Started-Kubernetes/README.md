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
 - [02. Terraform module](#02-Terraform-module)
 - [03. Your first Terraform module](#03-Your-first-Terraform-module)
   - [03.01. Add provider](#0301-Add-provider)
   - [03.02. Add namespace](#0302-Add-namespace)
   - [03.03. Execute terraform](#0303-Execute-terraform)

---

<!-- inPage TOC end -->

### Preface

- In this tutorial we will be learning what is terraform module and the basic CLI commands.

### 01. Getting started

- For this part we will be using minikube
- If you don't have minikube installed, got back to the [first lab](../00-Setup).
- Start minikube: `minikube start --driver=virtualbox`

### 02. Terraform module

- In Terraform, you should work by writing **modules**.
- `Terraform Modules` are folders with a set of terraform configuration files
- `Terraform Modules` stores information and can execute the action you need to complete.
- `Terraform Modules` are defined in Terraform Files.
  - Terraform files always end in the file extension `.tf`.
- Usually we will have `main.tf` file which is the root of the terraform module, but its not mandatory, we can also split our files into separate multiple files. Terraform will auto pick them up.

### 03. Your first Terraform module

- As mentioned previously, in Terraform we usually define a file names `main.tf` as our root module file.
- Create `main.tf`

```sh
# Create the working directory for our first module
mkdir codewizard-module

# Switch to the demo directory
cd codewizard-module

# Create the first terraform file
touch main.rf
```

### 03.01. Add provider

- In order to work with terraform you need to setup a [`provider`](https://registry.terraform.io/browse/providers).
- Providers are the implementation of Terraform to the desired API
- In this demo we will be using `Kubernetes` as our provider and `minikube` as our cluster

Docs: [https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs)

- The provider always first tries to load a config file from a given location when `config_path` or `config_paths` (or their equivalent environment variables) are set.
- Depending on whether you have a current context set this may require `config_context_auth_info` and/or `config_context_cluster `and/or `config_context`.

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

### 03.02. Add namespace

- Next we will be add a `resource` block.
- `Resource` describes one or more infrastructure objects, such as virtual networks, compute instances etc.
- Lets add k8s namespace resource

Docs: [https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace)

```hcl
resource "kubernetes_namespace" "tf_namespace_advanced" {

  # Set the metadata of the namespace
  metadata {
    annotations = {
      name = "example-annotation"
    }

    labels = {
      mylabel = "example-value"
    }

    # Set the desired namespace name
    name = "codewizard"
  }
}
```

### 03.03. Execute terraform

- Its time to run our first module
- The first command is `terraform init`, this command will download the provider api in our case `kubernetes`.

  ```hcl
  $ terraform init

  Initializing the backend...

  Initializing provider plugins...
  - Finding latest version of hashicorp/kubernetes...
  - Installing hashicorp/kubernetes v2.5.1...
  - Installed hashicorp/kubernetes v2.5.1 (signed by HashiCorp)

  Terraform has created a lock file .terraform.lock.hcl to record the provider
  selections it made above. Include this file in your version control repository
  so that Terraform can guarantee to make the same selections by default when
  you run "terraform init" in the future.

  Terraform has been successfully initialized!
  ```

  - The second command is `terraform plan`

  ```hcl
  $ terraform plan

  Terraform used the selected providers to generate the following execution plan.
  Resource actions are indicated with the following symbols:
    + create

  Terraform will perform the following actions:

    # kubernetes_namespace.tf_namespace_codewizard will be created
    + resource "kubernetes_namespace" "tf_namespace_codewizard" {
        + id = (known after apply)

        + metadata {
            + annotations      = {
                + "name" = "example-annotation"
              }
            + generation       = (known after apply)
            + labels           = {
                + "mylabel" = "example-value"
              }
            + name             = "codewizard"
            + resource_version = (known after apply)
            + uid              = (known after apply)
          }
      }

  Plan: 1 to add, 0 to change, 0 to destroy.
  ```

  - The last command is `terraform apply`

  ```hcl
  $ terraform apply

  Terraform used the selected providers to generate the following execution plan.
  Resource actions are indicated with the following symbols:
    + create

  Terraform will perform the following actions:

    # kubernetes_namespace.tf_namespace_codewizard will be created
    + resource "kubernetes_namespace" "tf_namespace_codewizard" {
        + id = (known after apply)

        + metadata {
            + annotations      = {
                + "name" = "example-annotation"
              }
            + generation       = (known after apply)
            + labels           = {
                + "mylabel" = "example-value"
              }
            + name             = "codewizard"
            + resource_version = (known after apply)
            + uid              = (known after apply)
          }
      }

  Plan: 1 to add, 0 to change, 0 to destroy.

  Do you want to perform these actions in workspace "codewizard"?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

  kubernetes_namespace.tf_namespace_codewizard: Creating...
  kubernetes_namespace.tf_namespace_codewizard: Creation complete after 0s [id=codewizard]

  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
  ```

- Test that the namespace was created
  ```hcl
  kubectl describe  ns codewizard
  ```
  <!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../08-Terraformer">08-Terraformer</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../10-Getting-Started-Helm-Chart">10-Getting-Started-Helm-Chart</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->