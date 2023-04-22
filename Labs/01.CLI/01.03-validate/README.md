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
- [Terraform CLI Docs - `terraform validate`](#terraform-cli-docs---terraform-validate)
  - [Notes](#notes)
- [01. Basic usage: `terraform validate`](#01-basic-usage-terraform-validate)
- [02. output validation](#02-output-validation)
- [03. Usage](#03-usage)
- [04. Hands-On](#04-hands-on)
  - [04.01. Valid content](#0401-valid-content)
  - [04.04. Invalid content](#0404-invalid-content)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform validate`

Docs: [https://www.terraform.io/docs/cli/commands/validate.html](https://www.terraform.io/docs/cli/commands/validate.html)

#### Notes

- The terraform validate command **validates the configuration files** in a directory, referring only to the configuration **and not accessing any remote services** such as remote state, provider APIs, etc.
- Validate runs checks that verify whether a configuration is **syntactically valid** and **internally consistent**, regardless of any provided variables or existing state.
- It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types.

### 01. Basic usage: `terraform validate`

- `terraform validate`: Confirms the Terraform file's syntax is correct
- Execute this command to confirm the code (HCL syntax) is valid.
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

### 03. Usage

| Command                           | Description                                   |
| --------------------------------- | --------------------------------------------- |
| terraform fmt                     | Format code based upon HCL canonical standard |
| terraform validate                | Validate code for syntax errors if any        |
| terraform validate -json          | Print validate output as json                 |
| terraform validate -backend=false | validate but skip backend validation          |

### 04. Hands-On

- Lets see it in action

#### 04.01. Valid content
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
terraform init
terraform validate

...

provider "kubernetes" {
  config_path = "~/.kube/config"
}

Initializing the backend...

Initializing provider plugins...
- Reusing previous version of hashicorp/kubernetes from the dependency lock file
- Using previously-installed hashicorp/kubernetes vX.X.X

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

*Success! The configuration is valid.*
```

#### 04.04. Invalid content

```sh
$ cat k8s.tf
###
### !!! There is "kubernetes2" provider (2023)
### Not a valid tf file
### 
provider "kubernetes2" {}

$ terraform validate
╷
│ Error: Missing required provider
│ 
│ This configuration requires provider registry.terraform.io/hashicorp/kubernetes2, but
│ that provider isn't available. You may be able to install it automatically by running:
│   terraform init
╵

$ terraform validate -json
{
  "format_version": "1.0",
  "valid": false,
  "error_count": 1,
  "warning_count": 0,
  "diagnostics": [
    {
      "severity": "error",
      "summary": "Missing required provider",
      "detail": "This configuration requires provider registry.terraform.io/hashicorp/kubernetes2, 
                 but that provider isn't available. You may be able to install it automatically by running:
                 terraform init"
    }
  ]
}
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