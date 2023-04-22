## ![](../../resources/terraform-logos.png)

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
   - [01.01. Create the main file](#0101-Create-the-main-file)
   - [01.02. Set the `kubeapi` port](#0102-Set-the-kubeapi-port)
 - [02. Define variable](#02-Define-variable)
   - [02.01. Input variables](#0201-Input-variables)

---

<!-- inPage TOC end -->

### Preface

- In this tutorial we will be learning how to use terraform variables.
- We will define K8S namespace which will be passed as parameter at runtime

### 01. Getting started

### 01.01. Create the main file

- As before lets define our `main.tf` with the Terraform provider

```hcl
# Add the kubernetes provider
provider "kubernetes" {
  # Set the minikbue context
  # Tell Terraform that we are running our cluster under Minikube.
  config_context_cluster = "minikube"

  # Set the path to the kubeconfig
  config_path = "~/.kube/config"

  # We need to set this port or the import might fail
  # This is the same port as we defined for the proxy
  host = "http://localhost:34567"
}

resource "kubernetes_namespace" "codewizard_namespace" {

}
```

### 01.02. Set the `kubeapi` port

- In order to be able to work with localhost we need to set the `kubeapi` port so terraform will be able to use it.
  ```sh
  # Set the desired port for kubeapi.
  # This port will be set under the kubernetes provider
  kubectl proxy --port=34567 --address='0.0.0.0' --accept-hosts='^.*' &
  ```

### 02. Define variable

- In terraform we have several types of variables

### 02.01. Input variables

- Input variables are usually defined by stating a name, type and a default value
- `type` & `default` are optional
- Lets set the namespace as parameter

```hcl
variable "namespace" {

  # The type is string
  type = string

  # Default value
  default = codewizard
}
```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.15-null_resource">01.15-null_resource</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../03-Functions">03-Functions</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->