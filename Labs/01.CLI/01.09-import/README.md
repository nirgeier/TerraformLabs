![](../../../resources/terraform-logos.png)

![Visitor Badge](https://visitor-badge.laobi.icu/badge?page_id=nirgeier)

---

<!-- omit from toc -->
# Terraform Hands-on Repository

- A collection of Hands-on labs for Terraform.
- Each lab is a standalone lab and does not require to complete the previous labs.

---

![](../../../resources/lab.jpg)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/TerraformLabs)

<!-- omit from toc -->
### **<kbd>CTRL</kbd> + click to open in new window**

<!-- inPage TOC start -->

---
<!-- omit from toc -->
## Lab Highlights:
- [Preface](#preface)
- [01. Getting started](#01-getting-started)
- [01.02. Set the `kubeapi` port](#0102-set-the-kubeapi-port)
- [01.03. Set the `kubernetes` provider](#0103-set-the-kubernetes-provider)
- [02. Import the namespace](#02-import-the-namespace)
- [02.01. Add the missing configuration](#0201-add-the-missing-configuration)
- [02.02. Try to import again](#0202-try-to-import-again)
- [02.03. Check the import](#0203-check-the-import)
- [03. Modify the namespace](#03-modify-the-namespace)
- [03.01. Add label to the namespace](#0301-add-label-to-the-namespace)
- [03.01. Remove the existing resource form terraform](#0301-remove-the-existing-resource-form-terraform)
- [03.02. Import again to view changes](#0302-import-again-to-view-changes)
- [03.02. Verify changes](#0302-verify-changes)
- [04. `Terraform refresh`](#04-terraform-refresh)
- [04.01. Load the changes](#0401-load-the-changes)
- [04.02. Review changes](#0402-review-changes)
- [05. Cleanup](#05-cleanup)

---

<!-- inPage TOC end -->

### Preface

- In this tutorial we will be learning how to import existing resource using `terraform import`
- Terraform is able to import existing infrastructure.
- This allows you take resources you've created by some other means and bring it under Terraform management.

### 01. Getting started

- For this Lab we will create a namespace in our cluster and them we will import it

  ```sh
  # Clean any previous data is any
  $ kubectl delete ns codewizard
  namespace "codewizard" deleted

  # Create the desired namespace
  $ kubectl create ns codewizard
  namespace/codewizard created

  # Add label to our namespace
  $ kubectl label ns codewizard demo=terraform
  namespace/codewizard labeled
  ```

### 01.02. Set the `kubeapi` port

- In order to be able to work with localhost we need to set the `kubeapi` port so terraform will be able to use it.
  ```sh
  # Set the desired port for kubeapi.
  # This port will be set under the kubernetes provider
  kubectl proxy --port=34567 --address='0.0.0.0' --accept-hosts='^.*' &
  ```

### 01.03. Set the `kubernetes` provider

- In this sample since we will need to import we add the host entry

  ```hcl
  # Add the kubernetes provider
  provider "kubernetes" {
    # Set the minikbue context
    # Tell Terraform that we are running our cluster under Minikube.
    config_context_cluster = "minikube"

    # Set the path to the kubeconfig
    config_path = "~/.kube/config"

    # We need to set this port or the import might fail
    # This is the same port as we defined in the previous step
    host = "http://localhost:34567"
  }

  ```

### 02. Import the namespace

- Lets import the existing namespace with terraform
- The import command for importing namespace is the following:

```hcl
$ terraform import kubernetes_namespace.codewizard_namespace codewizard
```

- If we did not set the kubeapi port we will likely to get error like:

  ```sh
  kubernetes_namespace.codewizard_namespace: Importing from ID "codewizard"...
  kubernetes_namespace.codewizard_namespace: Import prepared!
  Prepared kubernetes_namespace for import
  kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]

  # This is the error that we might get if the port is not set (the default is port 80)
  Error: Get "http://localhost/api/v1/namespaces/codewizard": dial tcp [::1]:80: connect: connection refused
  ```

---

### 02.01. Add the missing configuration

- We expect to get the following error:

  ```hcl
  Error: resource address "kubernetes_namespace.codewizard_namespace" does not exist in the configuration.

  Before importing this resource, please create its configuration in the root module. For example:

  resource "kubernetes_namespace" "codewizard_namespace" {
    # (resource arguments)
  }
  ```

> **In order to use Terraform import with a remote state backend,**  
> **you may need to set local variables equivalent to the remote workspace variables.**

- Lets fix it by adding the code above to our main.tf
  ```hcl
  # Add this line to the main.tf
  resource "kubernetes_namespace" "codewizard_namespace" {}
  ```

### 02.02. Try to import again

- Once we added the missing configuration we can try and import again
- Now we expect to see the success message: `Import successful!`

  ```hcl
  $ terraform import kubernetes_namespace.codewizard_namespace codewizard

  kubernetes_namespace.codewizard_namespace: Importing from ID "codewizard"...
  kubernetes_namespace.codewizard_namespace: Import prepared!
    Prepared kubernetes_namespace for import
  kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]

  Import successful!

  The resources that were imported are shown above. These resources are now in
  your Terraform state and will henceforth be managed by Terraform.
  ```

---

### 02.03. Check the import

- First lets see the resource name
  ```hcl
  $ terraform state list
  kubernetes_namespace.codewizard_namespace
  ```
- Now lets see what was imported.

  ```hcl
  $ terraform show

  # kubernetes_namespace.codewizard_namespace:
  resource "kubernetes_namespace" "codewizard_namespace" {
      id = "codewizard"

      metadata {
          annotations      = {}
          generation       = 0
          labels           = {
            "role" = "terraform"
          }
          labels           = {}
          name             = "codewizard"
          resource_version = "10266"
          uid              = "30746c98-f7de-426c-9cea-0190aabbeff8"
      }

      timeouts {}
  }
  ```

### 03. Modify the namespace

### 03.01. Add label to the namespace

- Lets add some label to the namespace

  ```sh
  kubectl label ns codewizard test-label=123
  ```

- Test that the label was added

  ```sh
  kubectl describe ns codewizard
  ```

### 03.01. Remove the existing resource form terraform

- Lets remove the existing namespace and re-import it to see if terraform will pick the added labels

  ```hcl
  $ terraform state rm kubernetes_namespace.codewizard_namespace

  Removed kubernetes_namespace.codewizard_namespace
  Successfully removed 1 resource instance(s).
  ```

### 03.02. Import again to view changes

```hcl
$ terraform import kubernetes_namespace.codewizard_namespace codewizard
kubernetes_namespace.codewizard_namespace: Importing from ID "codewizard"...
kubernetes_namespace.codewizard_namespace: Import prepared!
  Prepared kubernetes_namespace for import
kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.
```

### 03.02. Verify changes

- Verify that terraform grab the labels that we added

  ```hcl
  $ terraform show

  # kubernetes_namespace.codewizard_namespace:
  resource "kubernetes_namespace" "codewizard_namespace" {
      id = "codewizard"

      metadata {
          annotations      = {}
          generation       = 0
          labels           = {
              "role" = "terraform"
              "test-label" = "123" <--------------- The label we added
          }
          name             = "codewizard"
          resource_version = "17517"
          uid              = "30746c98-f7de-426c-9cea-0190aabbeff8"
      }

      timeouts {}
  }
  ```

### 04. `Terraform refresh`

- We can do the update which we did previously mush easier and faster with `terraform refresh`
- Lets update the namespace

  ```sh
  $ kubectl label ns codewizard test-label2=12345 --overwrite

  namespace/codewizard labeled
  ```

### 04.01. Load the changes

- Lets user `terraform refresh` to load the changes

  ```hcl
  $ terraform refresh

  kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]
  ```

### 04.02. Review changes

```hcl
terraform show
# kubernetes_namespace.codewizard_namespace:
resource "kubernetes_namespace" "codewizard_namespace" {
  id = "codewizard"

  metadata {
      annotations      = {}
      generation       = 0
      labels           = {
          "role" = "terraform"
          "test-label"  = "12345"
          "test-label2" = "12345"
      }
      name             = "codewizard"
      resource_version = "18253"
      uid              = "30746c98-f7de-426c-9cea-0190aabbeff8"
  }

  timeouts {}
}
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
  <a href="../01.08-show">01.08-show</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.10-state">01.10-state</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->