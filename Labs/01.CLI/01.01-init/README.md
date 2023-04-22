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

---

<!-- omit from toc -->
### Requirements

| Kubernetes                   | Terraform                          |
| ---------------------------- | ---------------------------------- |
| ![](../../../resources/k8s.png) | ![](../../../resources/terraform.png) |

<!-- inPage TOC start -->

---
<!-- omit from toc -->
## Lab Highlights:
- [Terraform CLI docs - `terraform init`](#terraform-cli-docs---terraform-init)
  - [Notes](#notes)
- [01. A bit about `init`](#01-a-bit-about-init)
- [02. `terraform init -backend`](#02-terraform-init--backend)
  - [02.01. What Backends Do?](#0201-what-backends-do)
- [03. `terraform init -get -upgrade`](#03-terraform-init--get--upgrade)
- [04. Working with plugins](#04-working-with-plugins)
- [05. Hands-On](#05-hands-on)

---

<!-- inPage TOC end -->

### Terraform CLI docs - `terraform init`

Docs: [https://www.terraform.io/docs/cli/commands/init.html](https://www.terraform.io/docs/cli/commands/init.html)

#### Notes

- The `terraform init` command is used to initialize a working directory containing Terraform configuration files.
  - **By default, terraform init assumes that the working directory already contains a configuration and will attempt to initialize that configuration.**
  - Optionally, init can be run against an empty directory with the `-from-module=MODULE-SOURCE` option, in which case the given module will be **copied into** the target directory before any other initialization steps are run.

---

### 01. A bit about `init`

- This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control.
- It is safe to run this command multiple times.
- `terraform init` is executed in the same directory as the `.tf` files **or nothing will happen**.
- To initialize a working directory for validation without accessing any configured remote backend, use:
  ```sh
  # Initialize a working directory for validation
  terraform init -backend=false
  ```
- You should see the following output:

  ```sh
  Terraform initialized in an empty directory!

  The directory has no Terraform configuration files. You may begin working
  with Terraform immediately by creating Terraform configuration files.
  ```

- Examples:

  | Command                                | Description                                                         |
  | -------------------------------------- | ------------------------------------------------------------------- |
  | `terraform init`                       | Initialize directory, pull down providers                           |
  | `terraform init -get-plugins=false`    | initialize directory, do not download plugins                       |
  | `terraform init -verify-plugins=false` | initialize directory, do not verify plugins for Hashicorp signature |

---

### 02. `terraform init -backend`

- Each Terraform configuration can specify a **backend**, which defines where and how operations are performed, where state snapshots are stored, etc.
- Backend configuration is only used by Terraform CLI. (Not by terraform cloud)

#### 02.01. What Backends Do?

- There are two areas of Terraform's behavior that are determined by the backend:

  - **Where state is stored.**
    - Terraform uses persistent state data to keep track of the resources it manages.
  - **Where operations are performed.**

    - "Operations" refers to performing API requests against infrastructure services in order to create, read, update, or destroy resources. Not every terraform subcommand performs API operations; many of them only operate on state data.

    - Only two backends actually perform operations: **local** and **remote**.
    - The **local backend** performs API operations **directly from the machine** where the terraform command is run.
    - Whenever you use a backend other than local or remote, Terraform uses the local backend for operations; it only uses the configured backend for state storage.

---

### 03. `terraform init -get -upgrade`

- Using init to fetch updates

  - Lets assume that we already have been working on Terraform and there is an update to one of the providers.
  - In order to update the providers we will add 2 flags:

  ```sh
  # -get=true
  #                   Download any modules for this configuration.
  #
  #  -upgrade=true    If installing modules (-get) or plugins, ignore
  #                   previously-downloaded objects and install the
  #                   latest version allowed within configured constraints.

  $ terraform init -get=true -upgrade=true
  ```

- Sample output
  - If we had previous state terraform will use the existing resources (line 2 - Reusing previous version)
  ```sh
  Initializing provider plugins...
  Reusing previous version of hashicorp/kubernetes from the dependency lock file
  Using previously-installed hashicorp/kubernetes v2.5.1
  ```
  - With the flags added: (line 2 - Finding latest version)
  ```sh
  Initializing provider plugins...
  Finding latest version of hashicorp/kubernetes...
  Installing hashicorp/kubernetes vX.X.X
  Installed hashicorp/kubernetes vX.X.X (signed by HashiCorp)
  ```

---

### 04. Working with plugins

- When we initializing the terraform project we can control what is the desired behavior of plugins
- Most Terraform providers are published separately from Terraform as **plugins**.
- Terraform searches the configuration for both direct and indirect references to providers and **attempts to install the plugins** for those providers.

- You can modify terraform **init's plugin** behavior with the following options:
- `- upgrade` = Upgrade all previously-selected plugins **to the newest version** that complies with the configuration's version constraints. This will cause Terraform to ignore any selections recorded in the dependency lock file, and to take the newest available version matching the configured version constraints.
- `-get-plugins=false` = **Skip** plugin installation.

- For offline Terraform you can also use:
  - `-plugin-dir=PATH` = Force plugin installation to read plugins only from the specified directory.

### 05. Hands-On

- In order to see `terraform init` in action lest create a resource and see the outputs.
- Execute the `demo.sh` script in the folder

```sh
# Execute the demo - Create K8S provider for test
./01-init-demo.sh

$ cat k8s.tf
###
###
### Initialize kubernetes provider
###
###

provider "kubernetes" {
  config_path = "~/.kube/config"
}

$ terraform init

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/kubernetes...
- Installing hashicorp/kubernetes v2.19.0...
- Installed hashicorp/kubernetes v2.19.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

$ tree -a .
.
├── .terraform
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── kubernetes
│                   └── 2.19.0
│                       └── darwin_amd64
│                           └── terraform-provider-kubernetes_v2.19.0_x5
├── .terraform.lock.hcl
└── k8s.tf

8 directories, 3 files
```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../../00-Setup">00-Setup</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.02-get">01.02-get</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->