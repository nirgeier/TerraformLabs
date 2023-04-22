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
- [Terraform CLI Docs - `terraform workspace`](#terraform-cli-docs---terraform-workspace)
- [Pre-Requirements](#pre-requirements)
- [01. `terraform workspace`](#01-terraform-workspace)
- [Hand-On](#hand-on)
- [02. Create workspace](#02-create-workspace)
- [03. Switch to workspace](#03-switch-to-workspace)
- [04. Use workspace names](#04-use-workspace-names)
- [05. Use workspace as condition](#05-use-workspace-as-condition)
- [06. Usage:](#06-usage)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform workspace`

- [Official docs](https://www.terraform.io/language/state/workspaces)

### Pre-Requirements

- In order to be able to work with localhost we need to set the `kubeapi` port so terraform will be able to use it.

```sh
# Set the desired port for kubeapi.
# This port will be set under the kubernetes provider
# We will set the same port in the main.tf as well (34567 in this sample)
kubectl proxy --port=34567 --address='0.0.0.0' --accept-hosts='^.*' &
```

- The sample `main.tf`

```sh
# Add the kubernetes provider
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"

  # We need to set this port or the import might fail
  # This is the same port as we defined for the proxy few lines above
  host = "http://localhost:34567"
}

# Define a "New" namespace resource
resource "kubernetes_namespace" "codewizard_namespace" {

  # Set the desired namespace
  metadata{
    name = "codewizard"
  }
}
```

### 01. `terraform workspace`

Docs: [`terraform workspace`](https://www.terraform.io/docs/language/state/workspaces.html)

- Each Terraform configuration has an associated backend that defines how operations are executed and where persistent data such as the Terraform state are stored.
- The persistent data stored in the backend belongs to a workspace.
- Initially the backend has only one workspace, called "default", and thus there is only one Terraform state associated with that configuration.
- `workspaces` can be used for support multiple environments, for storing different states and for collaborating.
- Switching between workspaces switch the data
- Terraform cab append the environment name to the workspace

---

### Hand-On

### 02. Create workspace

- Lets create a workspace and than use it without existing namespace

```hcl
# Create terraform workspace
$ terraform workspace new dev

Created and switched to workspace "dev"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuration.
```

---

### 03. Switch to workspace

```hcl
# Create terraform workspace
$ terraform workspace select dev

# Verify that we are on the desired workspace
$ terraform workspace list

  default
  codewizard
* dev

# We can also see it internally in .terraform
cat  .terraform/environment

dev
```

---

### 04. Use workspace names

- We can use the workspace name in our resources, useful when we wish to reuse the modules but create (apply) it to multiple environments.
- Lets update our main.tf and add some prefix to our namespace name

```hcl
# update the name space with the following prefix:
# ${terraform.workspace}

# Define a "New" namespace resource
resource "kubernetes_namespace" "codewizard_namespace" {

  # Set the desired namespace
  metadata{
    name = "${terraform.workspace}-codewizard"
  }
}
```

- Test to see the name prefix:

```hcl
$ terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_namespace.codewizard_namespace will be created
  + resource "kubernetes_namespace" "codewizard_namespace" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "dev-codewizard" <------------ The name with the prefix
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

---

### 05. Use workspace as condition

- We can set different values for our resources based upon the workspace
- In this sample we will check to see if we are on dev workspace and if so set a different name

```hcl
# Update the main.tf with the following lines:

# Define a "New" namespace resource
resource "kubernetes_namespace" "codewizard_namespace" {

  # Set the desired namespace
  metadata{
    name = "${terraform.workspace == "qa" ? "qa" : "not-qa"}-codewizard"
  }
}
```

- Check to see out changes

```hcl
terraform plan

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_namespace.codewizard_namespace will be created
  + resource "kubernetes_namespace" "codewizard_namespace" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "not-qa-codewizard" <------------- The desired change
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.
```

---

### 06. Usage:

- Examples:

  | Command                                   | Description                      |
  | ----------------------------------------- | -------------------------------- |
  | terraform workspace **new** codewizard    | Create a new workspace           |
  | terraform workspace **select** codewizard | Change to the selected workspace |
  | terraform workspace **list**              | List out all workspaces          |

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.10-state">01.10-state</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.12-graph">01.12-graph</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->