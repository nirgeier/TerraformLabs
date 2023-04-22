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
- [Terraform CLI Docs - `terraform apply`](#terraform-cli-docs---terraform-apply)
  - [Notes](#notes)
- [01. Run `terraform apply`](#01-run-terraform-apply)
- [02. Usage](#02-usage)
- [03. Example](#03-example)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform apply`

Docs: [https://www.terraform.io/docs/cli/commands/apply.html](https://www.terraform.io/docs/cli/commands/apply.html)

#### Notes

- The `terraform apply` command **executes the actions** proposed in a Terraform plan.
- The most straightforward way to use `terraform apply` is to run it without any arguments at all, in which case **it will automatically create a new execution plan** (as if you had run terraform plan) and then prompt you to approve that plan, before taking the indicated actions.
- Another way to use `terraform apply` is to pass it the filename of a **(pre) saved plan file** you created earlier with terraform plan `-out=...`, **in which case Terraform will apply the changes** in the plan without any confirmation prompt. This two-step workflow is primarily intended for when running Terraform in automation.
- We can save the output of the plan to file and to use it with the `apply` command.
- In the default case, **with no saved plan file**, terraform apply creates its own plan of action, in the same way that terraform plan would, in other words if we don't execute `terraform plan` prior to terraform apply and pass the plan file, terraform will execute `terraform plan` in any case.

---

### 01. Run `terraform apply`

- As mentioned above when executing `terraform apply` terraform will run `terraform plan` and will ask for out approval unless we added the `-auto-approve` flag

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
  | terraform apply -auto-approve          | Apply changes without being prompted to enter “yes”             |
  | terraform apply plan.out               | Use the plan.out plan file to deploy infrastructure             |
  | terraform apply -target=xxxx           | Only apply/deploy changes to the selected targeted resource     |
  | terraform apply -var my_variable=value | Pass a variable via command-line while applying a configuration |

### 03. Example

```hcl
Initializing the backend...

Initializing provider plugins...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.kubernetes: version = "~> 2.1"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

### provider.tf
provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "minikube"
}

### namespace.tf
resource "kubernetes_namespace" "codewizard" {
  metadata {
    name = "05-apply"
  }
}

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
          + name             = "05-apply"
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
kubernetes_namespace.codewizard: Creation complete after 0s [id=05-apply]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

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