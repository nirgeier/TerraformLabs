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

---

### Pre-Requirements

- This tutorial will walk you using terraform locally without any requirements for any cloud provider.
- The labs require the following tools:
- If you are using GCP all the tools are **pre-installed**

| Terraform                          | Kubernetes                   | Minikube                          | Helm                          | kubectl                          |
| ---------------------------------- | ---------------------------- | --------------------------------- | ----------------------------- | -------------------------------- |
| ![](../../resources/terraform.png) | ![](../../resources/k8s.png) | ![](../../resources/minikube.png) | ![](../../resources/helm.png) | ![](../../resources/kubectl.jpg) |

| Tool          | Comments                                                                                                 |
| ------------- | -------------------------------------------------------------------------------------------------------- |
| K8S           | An existing cluster or any other local tool as described [here](https://kubernetes.io/docs/tasks/tools/) |
| **kubectl**   | The Kubernetes command-line tool, kubectl                                                                |
| **minikube**  | Local cluster for running the hands on labs                                                              |
| **Helm**      | Some of the demos will require helm charts installed                                                     |
| **Terraform** | Do i need to explain why???                                                                              |

<!-- inPage TOC start -->

---
<!-- omit from toc -->
## Lab Highlights:
 - [01. Install](#01-Install)
   - [01.01. Install minikube](#0101-Install-minikube)
   - [01.02. Install helm](#0102-Install-helm)
   - [01.03. Install Terraform](#0103-Install-Terraform)
 - [02. Verify installation](#02-Verify-installation)

---

<!-- inPage TOC end -->

### 01. Install

### 01.01. Install minikube

```sh
# Install minikube
curl -fsSL -o minikube \
  https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
```

### 01.02. Install helm

```sh
# Install helm
curl -fsSL -o get_helm.sh \
  https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh
```

### 01.03. Install Terraform

- install terraform based upon your os as described [https://learn.hashicorp.com/tutorials/terraform/install-cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)

### 02. Verify installation

```sh
# check minikube
minikube status

# Check helm
helm version

# Check kubectl
kubectl
```

<!-- navigation start -->

---

<div align="center">
  <a href="../01.00-CLI-Commands">01.00-CLI-Commands</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->