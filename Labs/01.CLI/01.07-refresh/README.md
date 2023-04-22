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
- [Terraform CLI Docs - `terraform refresh`](#terraform-cli-docs---terraform-refresh)
  - [Notes](#notes)
- [01. `terraform refresh` without exiting resources](#01-terraform-refresh-without-exiting-resources)
- [02. Refresh existing resource](#02-refresh-existing-resource)
- [03. Create a change](#03-create-a-change)
- [04. Refresh the changes](#04-refresh-the-changes)
- [05. View the changes](#05-view-the-changes)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform refresh`

Docs: [https://www.terraform.io/docs/cli/commands/refresh.html](https://www.terraform.io/docs/cli/commands/refresh.html)

#### Notes

- The `terraform refresh` command reads the current settings from all managed remote objects and updates the Terraform state to match.
- This **won't modify** your real remote objects, but it **will modify** the the Terraform state.
- This ensures Terraform has an accurate view of what is in the current environment.
- You shouldn't typically need to use this command, because Terraform automatically performs the same refreshing actions as a part of creating a plan in both the `terraform plan` and `terraform apply` commands.
- This command is here primarily for backward compatibility, but we don't recommend using it because it provides no opportunity to review the effects of the operation before updating the state.

### 01. `terraform refresh` without exiting resources

```hcl
$ terraform refresh
╷
│ Warning: Empty or non-existent state
│
│ There are currently no resources tracked in the state, so there is nothing to refresh.
```

### 02. Refresh existing resource

- If there are no changes:

```hcl
$ terraform refresh
kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]
```

### 03. Create a change

- Lets create a change and than refresh

```sh
# Add label to the desired namespace
kubectl label ns codewizard role=admin
```

### 04. Refresh the changes

- Refresh and check the changes

```hcl
$ terraform refresh

kubernetes_namespace.codewizard_namespace: Refreshing state... [id=codewizard]
```

### 05. View the changes

```hcl
# use the `terraform state` command with the resource name to view the changes

$ terraform state show kubernetes_namespace.codewizard_namespace

# kubernetes_namespace.codewizard_namespace:
resource "kubernetes_namespace" "codewizard_namespace" {
    id = "codewizard"

    metadata {
        annotations      = {}
        generation       = 0
        labels           = {
            "role" = "admin" <-------- Here is our change
        }
        name             = "codewizard"
        resource_version = "903"
        uid              = "922b6194-5870-4759-b94f-146785cd319b"
    }
}
```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.06-destroy">01.06-destroy</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.08-show">01.08-show</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->