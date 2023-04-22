![](../../../resources/terraform-logos.png)

---

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
- [Terraform CLI Docs - `terraform state`](#terraform-cli-docs---terraform-state)
  - [Notes](#notes)
- [01. `terraform.tfstate`](#01-terraformtfstate)
- [02. `terraform show`](#02-terraform-show)
- [03. State commands](#03-state-commands)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform state`

#### Notes

- Each Terraform configuration has an associated **backend** that defines how operations are executed and where persistent data such as the Terraform **state are stored**.
- The persistent data stored in the backend belongs to a workspace.
- Initially the backend has only one workspace, called `default`, and thus there is only one Terraform state associated with that configuration.
- Terraform must store `state` about your managed infrastructure and configuration.
- This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.
- This state is stored by default in a local file named `terraform.tfstate`, but it can also be stored remotely, which works better in a team environment.
- Terraform uses this local state to create plans and make changes to your infrastructure.
- Prior to any operation, Terraform does a refresh to update the state with the real infrastructure.

---

### 01. `terraform.tfstate`

- The default file for storing the state is in `terraform.tfstate`
- the file format is json and it stored information about the resources and some metadata as well.

```sh
$ cat terraform.tfstate

{
  "version": 4,
  "terraform_version": "1.0.9",
  "serial": 9,
  "lineage": "052ffe5f-c8a1-cb7d-26d1-c4cc01d03cfc",
  "outputs": {},
  "resources": [
    {
      "mode": "managed",
      "type": "kubernetes_namespace",
      "name": "codewizard_namespace",
      "provider": "provider[\"registry.terraform.io/hashicorp/kubernetes\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "id": "codewizard",
            "metadata": [
              {
                "annotations": null,
                "generate_name": "",
                "generation": 0,
                "labels": null,
                "name": "codewizard",
                "resource_version": "537",
                "uid": "6f71ff79-e86f-4a51-abff-351f80f55c1e"
              }
            ],
            "timeouts": null
          },
          "sensitive_attributes": [],
          "private": "eyJlMmJmYjczMC1lY2FhLTExZTYtOGY4OC0zNDM2M2JjN2M0YzAiOnsiZGVsZXRlIjozMDAwMDAwMDAwMDB9fQ=="
        }
      ]
    }
  ]
}
```

---

### 02. `terraform show`

- The terraform show command is used to provide human-readable output from a state or plan file.
- For example here is a show output

```hcl
$ terraform show

# kubernetes_namespace.codewizard_namespace:
resource "kubernetes_namespace" "codewizard_namespace" {
    id = "not-qa-codewizard"

    metadata {
        generation       = 0
        name             = "not-qa-codewizard"
        resource_version = "1833"
        uid              = "b502d9c5-bf89-4dfe-ad2d-46658f965cf9"
    }
}
```

- We can also print output in json format

```hcl
$ terraform show -json

{
   "format_version":"0.2",
   "terraform_version":"1.0.9",
   "values":{
      "root_module":{
         "resources":[
            {
               "address":"kubernetes_namespace.codewizard_namespace",
               "mode":"managed",
               "type":"kubernetes_namespace",
               "name":"codewizard_namespace",
               "provider_name":"registry.terraform.io/hashicorp/kubernetes",
               "schema_version":0,
               "values":{
                  "id":"not-qa-codewizard",
                  "metadata":[
                     {
                        "annotations":null,
                        "generate_name":"",
                        "generation":0,
                        "labels":null,
                        "name":"not-qa-codewizard",
                        "resource_version":"1833",
                        "uid":"b502d9c5-bf89-4dfe-ad2d-46658f965cf9"
                     }
                  ],
                  "timeouts":null
               }
            }
         ]
      }
   }
}

```

---

### 03. State commands

| Command                | Description                                                                               |
| ---------------------- | ----------------------------------------------------------------------------------------- |
| state list             | List resources within a Terraform state.                                                  |
| state mv               | Not a common command , should be used with caution. Usage example: rename a resource      |
| state pull             | Manually download and output the state from remote state.                                 |
| state push             | Manually upload a local state file to remote state.                                       |
| state replace-provider | Replace the provider for resources in a Terraform state.                                  |
| state rm               | Remove the record, Terraform will no longer be tracking the corresponding remote objects. |
| state show             | Show the attributes of a single resource in the Terraform state.                          |

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.09-import">01.09-import</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.11-workspace">01.11-workspace</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->