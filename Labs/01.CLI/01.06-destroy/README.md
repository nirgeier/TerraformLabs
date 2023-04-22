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
- [Terraform CLI Docs - `terraform destroy`](#terraform-cli-docs---terraform-destroy)
  - [Notes](#notes)
- [01. `terraform plan -destroy`](#01-terraform-plan--destroy)
- [02. Execute `terraform plan / terraform plan -destroy`](#02-execute-terraform-plan--terraform-plan--destroy)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform destroy`

Docs: [https://www.terraform.io/docs/cli/commands/destroy.html](https://www.terraform.io/docs/cli/commands/destroy.html)

#### Notes

- The `terraform destroy` command is a convenient way to **destroy all remote objects** managed by a particular Terraform configuration.
- While you will typically not want to destroy long-lived objects in a production environment, Terraform is sometimes used to manage ephemeral infrastructure for development purposes, in which case you can use terraform destroy to conveniently clean up all of those temporary objects once you are finished with your work.
- This will permanently remove anything created and stored in the state file from the cluster.

```hcl
$ terraform destroy
```

---

### 01. `terraform plan -destroy`

- When we run `terraform plan` a creation plan is created, if we will pass the `-destroy` flag it will create a speculative destroy plan.

```hcl
$ terraform plan -destroy
```

- This will run terraform plan in destroy mode, showing you the proposed destroy changes **without executing them**.

### 02. Execute `terraform plan / terraform plan -destroy`

```hcl
$ cat provider.tf
provider "kubernetes" {
  config_path = "~/.kube/config"
}

$ namespace.tf
resource "kubernetes_namespace" "codewizard" {
  metadata {
    name = "06-destroy"
  }
}

$kubectl delete ns 06-destroy
namespace "06-destroy" deleted

$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_namespace.codewizard will be created
  + resource "kubernetes_namespace" "codewizard" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "06-destroy"
          + resource_version = (known after apply)
          + self_link        = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

$ terraform apply -auto-approve
kubernetes_namespace.codewizard: Creating...
kubernetes_namespace.codewizard: Creation complete after 0s [id=06-destroy]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

$ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

kubernetes_namespace.codewizard: Refreshing state... [id=06-destroy]

------------------------------------------------------------------------

#
# Here we can see plan once the resources are already exist
#
>>>>>>>>> No changes. Infrastructure is up-to-date.

This means that Terraform did not detect any differences between your
configuration and real physical resources that exist. As a result, no
actions need to be performed.
+ terraform plan -destroy
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

kubernetes_namespace.codewizard: Refreshing state... [id=06-destroy]

------------------------------------------------------------------------

#
# Here we can see `plan -destroy` once the resources are already exist
# The `-destroy` will generate a destroy plan
#
An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # kubernetes_namespace.codewizard will be destroyed
  - resource "kubernetes_namespace" "codewizard" {
      - id = "06-destroy" -> null

      - metadata {
          - annotations      = {} -> null
          - generation       = 0 -> null
          - labels           = {} -> null
          - name             = "06-destroy" -> null
          - resource_version = "506934" -> null
          - uid              = "f825b9e6-d134-4481-b965-e820ea387950" -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.05-apply">01.05-apply</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.07-refresh">01.07-refresh</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->