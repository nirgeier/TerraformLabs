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

- [01. Basic usage: `terraform validate`](#01-Basic-usage-terraform-validate)
- [02. output validation](#02-output-validation)
- [03. Examples](#03-Examples)
- [04. Hands-On](#04-Hands-On)

---

<!-- inPage TOC end -->

### Terraform CLI - `terraform validate`

Docs: [https://www.terraform.io/docs/cli/commands/validate.html](https://www.terraform.io/docs/cli/commands/validate.html)

- The terraform validate command **validates the configuration files** in a directory, referring only to the configuration **and not accessing any remote services** such as remote state, provider APIs, etc.
- Validate runs checks that verify whether a configuration is **syntactically valid** and **internally consistent**, regardless of any provided variables or existing state.
- It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types.

### 01. Basic usage: `terraform validate`

- `terraform validate`: Confirms the Terraform file's syntax is correct
- Always run this to confirm the code is built correctly.
  ```sh
  terraform validate
  ```
- You should see the following output:
  ```sh
  # no error found
  Success! The configuration is valid.
  ```

### 02. output validation

- `terraform validate -json` will print out validation in a json format

  Docs: [https://www.terraform.io/docs/cli/commands/validate.html#json-output-format](https://www.terraform.io/docs/cli/commands/validate.html#json-output-format)

  ```sh
  $ terraform validate -json
  {
    "format_version": "0.1",
    "valid": true,
    "error_count": 0,
    "warning_count": 0,
    "diagnostics": []
  }
  ```

### 03. Examples

| Command                           | Description                                   |
| --------------------------------- | --------------------------------------------- |
| terraform fmt                     | Format code based upon HCL canonical standard |
| terraform validate                | Validate code for syntax errors if any        |
| terraform validate -json          | Print validate output as json                 |
| terraform validate -backend=false | validate but skip backend validation          |

### 04. Hands-On

- Lets see it in action

```sh
# Create a k8s provider
echo 'provider "kubernetes" {}' > k8s.tf

# Validate the file
terraform validate
Success! The configuration is valid.

# Create file which will not pass validation
# No such provider `kubernetes2`
echo 'provider "kubernetes2" {}' > k8s.tf

# Validate the file
terraform validate

...

Error: provider.kubernetes2: no suitable version installed
  version requirements: "(any version)"
  versions installed: none
```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.02-get">01.02-get</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.04-plan">01.04-plan</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->

7dxSqe7G#xT!\*SR$24S2@98qg
