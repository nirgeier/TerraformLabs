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
 - [01. Run `terraform apply`](#01-Run-terraform-apply)
 - [02. Usage](#02-Usage)

---

<!-- inPage TOC end -->

### Terraform CLI - `terraform apply`

Docs: [https://www.terraform.io/docs/cli/commands/apply.html](https://www.terraform.io/docs/cli/commands/apply.html)

- The `terraform apply` command **executes the actions** proposed in a Terraform plan.
- The most straightforward way to use `terraform apply` is to run it without any arguments at all, in which case |**it will automatically create a new execution plan** (as if you had run terraform plan) and then prompt you to approve that plan, before taking the indicated actions.
- Another way to use `terraform apply` is to pass it the filename of a saved plan file you created earlier with terraform plan -out=..., in which case Terraform will apply the changes in the plan without any confirmation prompt. This two-step workflow is primarily intended for when running Terraform in automation.
- We can save the output of the plan to file and to use it with the `apply` command.
- In the default case, **with no saved plan file**, terraform apply creates its own plan of action, in the same way that terraform plan would, in other words if we don't execute `terraform plan` prior to terraform apply and pass the plan file, terraform will execute `terraform plan` in any case.

---

### 01. Run `terraform apply`

- As mentioned above when executing `terraform apply` terraform will run `terraform plan` and will ask for out approval unless we added the `--auto-approve` flag

```hcl
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # kubernetes_namespace.codewizard_namespace will be created
  + resource "kubernetes_namespace" "codewizard_namespace" {
      + id = (known after apply)

      + metadata {
          + generation       = (known after apply)
          + name             = "codewizard"
          + resource_version = (known after apply)
          + uid              = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value:
```

### 02. Usage

- Examples:

  | Command                                | Description                                                     |
  | -------------------------------------- | --------------------------------------------------------------- |
  | terraform apply --auto-approve         | Apply changes without being prompted to enter “yes”             |
  | terraform apply plan.out               | Use the plan.out plan file to deploy infrastructure             |
  | terraform apply -target=xxxx           | Only apply/deploy changes to the selected targeted resource     |
  | terraform apply -var my_variable=value | Pass a variable via command-line while applying a configuration |

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.04-plan">01.04-plan</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.06-destroy">01.06-destroy</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->