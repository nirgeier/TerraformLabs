![](../../../resources/terraform-logos.png)

---

![Visitor Badge](https://visitor-badge.laobi.icu/badge?page_id=nirgeier)

---

# Terraform Hands-on Repository

- A collection of Hands-on labs for Terraform.
- Each lab is a standalone lab and does not require to complete the previous labs.

---

![](../../resources/lab.jpg)

[![Open in Cloud Shell](https://gstatic.com/cloudssh/images/open-btn.svg)](https://console.cloud.google.com/cloudshell/editor?cloudshell_git_repo=https://github.com/nirgeier/TerraformLabs)

### **<kbd>CTRL</kbd> + click to open in new window**

<!-- inPage TOC start -->

---
## Lab Highlights:
 - [01. `terraform plan -destroy`](#01-terraform-plan--destroy)
 - [02. Execute `terraform destroy`](#02-Execute-terraform-destroy)

---

<!-- inPage TOC end -->

### Terraform CLI - `terraform destroy`

Docs: [https://www.terraform.io/docs/cli/commands/destroy.html](https://www.terraform.io/docs/cli/commands/destroy.html)

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

### 02. Execute `terraform destroy`

```hcl
terraform destroy
kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]

Terraform used the selected providers to generate the following execution plan.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # kubernetes_namespace.codewizard_namespace will be destroyed
  - resource "kubernetes_namespace" "codewizard_namespace" {
      - id = "codewizard" -> null

      - metadata {
          - annotations      = {} -> null
          - generation       = 0 -> null
          - labels           = {
              - "role" = "admin"
            } -> null
          - name             = "codewizard" -> null
          - resource_version = "903" -> null
          - uid              = "922b6194-5870-4759-b94f-146785cd319b" -> null
        }
    }

Plan: 0 to add, 0 to change, 1 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

kubernetes_namespace.codewizard_namespace: Destroying... [id=codewizard]
kubernetes_namespace.codewizard_namespace: Destruction complete after 6s

Destroy complete! Resources: 1 destroyed.
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