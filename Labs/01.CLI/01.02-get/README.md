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
- [Terraform CLI Docs - `terraform get`](#terraform-cli-docs---terraform-get)
  - [Notes](#notes)
- [01. Hand-On](#01-hand-on)
  - [01.01. Empty modules](#0101-empty-modules)
  - [01.02. With Modules](#0102-with-modules)
  - [01.03. Output](#0103-output)

---

<!-- inPage TOC end -->

### Terraform CLI Docs - `terraform get`

Docs: [https://www.terraform.io/cli/commands/get](https://www.terraform.io/cli/commands/get)

#### Notes

- The `terraform get` command is used to **download and update** modules mentioned in the **root** module.
- The modules are downloaded into a .terraform subdirectory of the current working directory

### 01. Hand-On

#### 01.01. Empty modules

- First we will "get" folder without any modules

```sh
# Init an empty folder
terraform init

### Output
# Terraform initialized in an empty directory!
#
# The directory has no Terraform configuration files.
# You may begin working with Terraform immediately by
# creating Terraform configuration files.

# "Download" the modules, in this case it will be empty
terraform get

#
tree -a

# .
# └── .terraform
#     └── modules
#         └── modules.json
```

#### 01.02. With Modules

```sh
# Create a module to use.
# In this demo we will use Consul as our module
cat <<EOF > module.tf
module "consul" {
  source  = "hashicorp/consul/aws"
}
EOF

# Init an empty folder or use the existing one
terraform init

# Download the module
terraform get
```

#### 01.03. Output

```sh
# Create a module to use.
# In this demo we will use Consul as our module
module "consul" {
  source = "hashicorp/consul/aws"
}

Initializing the backend...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v4.62.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
.
├── .terraform
│   ├── modules
│   │   ├── consul
│   │   │   ├── .circleci
│   │   │   │   └── config.yml
│   │   │   ├── .git
│   │   │   │   ├── HEAD
│   │   │   │   ├── config
│   │   │   │   ├── description
│   │   │   │   ├── hooks
│   │   │   │   │   ├── applypatch-msg.sample
│   │   │   │   │   ├── commit-msg.sample
│   │   │   │   │   ├── fsmonitor-watchman.sample
│   │   │   │   │   ├── post-update.sample
│   │   │   │   │   ├── pre-applypatch.sample
│   │   │   │   │   ├── pre-commit.sample
│   │   │   │   │   ├── pre-merge-commit.sample
│   │   │   │   │   ├── pre-push.sample
│   │   │   │   │   ├── pre-rebase.sample
│   │   │   │   │   ├── pre-receive.sample
│   │   │   │   │   ├── prepare-commit-msg.sample
│   │   │   │   │   ├── push-to-checkout.sample
│   │   │   │   │   └── update.sample
│   │   │   │   ├── index
│   │   │   │   ├── info
│   │   │   │   │   └── exclude
│   │   │   │   ├── logs
│   │   │   │   │   ├── HEAD
│   │   │   │   │   └── refs
│   │   │   │   │       ├── heads
│   │   │   │   │       │   └── master
│   │   │   │   │       └── remotes
│   │   │   │   │           └── origin
│   │   │   │   │               └── HEAD
│   │   │   │   ├── objects
│   │   │   │   │   ├── info
│   │   │   │   │   └── pack
│   │   │   │   │       ├── pack-c5b19f0a8ee04c0b14927474c4cf25ed96b6a635.idx
│   │   │   │   │       └── pack-c5b19f0a8ee04c0b14927474c4cf25ed96b6a635.pack
│   │   │   │   ├── packed-refs
│   │   │   │   └── refs
│   │   │   │       ├── heads
│   │   │   │       │   └── master
│   │   │   │       ├── remotes
│   │   │   │       │   └── origin
│   │   │   │       │       └── HEAD
│   │   │   │       └── tags
│   │   │   ├── .gitignore
│   │   │   ├── .pre-commit-config.yaml
│   │   │   ├── CODEOWNERS
│   │   │   ├── CONTRIBUTING.md
│   │   │   ├── LICENSE
│   │   │   ├── NOTICE
│   │   │   ├── README.md
│   │   │   ├── _ci
│   │   │   │   ├── publish-amis-in-new-account.md
│   │   │   │   └── publish-amis.sh
│   │   │   ├── _docs
│   │   │   │   ├── architecture.png
│   │   │   │   ├── consul-ui-screenshot.png
│   │   │   │   └── package-managers.md
│   │   │   ├── examples
│   │   │   │   ├── README.md
│   │   │   │   ├── consul-ami
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── consul.json
│   │   │   │   ├── consul-examples-helper
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── consul-examples-helper.sh
│   │   │   │   ├── example-with-custom-asg-role
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── main.tf
│   │   │   │   │   ├── outputs.tf
│   │   │   │   │   ├── user-data-client.sh
│   │   │   │   │   ├── user-data-server.sh
│   │   │   │   │   └── variables.tf
│   │   │   │   ├── example-with-encryption
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── main.tf
│   │   │   │   │   ├── outputs.tf
│   │   │   │   │   ├── packer
│   │   │   │   │   │   ├── README.md
│   │   │   │   │   │   ├── ca.crt.pem
│   │   │   │   │   │   ├── consul-with-certs.json
│   │   │   │   │   │   ├── consul.crt.pem
│   │   │   │   │   │   └── consul.key.pem
│   │   │   │   │   ├── user-data-client.sh
│   │   │   │   │   ├── user-data-server.sh
│   │   │   │   │   └── variables.tf
│   │   │   │   └── root-example
│   │   │   │       ├── README.md
│   │   │   │       ├── user-data-client.sh
│   │   │   │       └── user-data-server.sh
│   │   │   ├── main.tf
│   │   │   ├── modules
│   │   │   │   ├── README.md
│   │   │   │   ├── consul-client-security-group-rules
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── main.tf
│   │   │   │   │   └── variables.tf
│   │   │   │   ├── consul-cluster
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── main.tf
│   │   │   │   │   ├── outputs.tf
│   │   │   │   │   └── variables.tf
│   │   │   │   ├── consul-iam-policies
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── main.tf
│   │   │   │   │   └── variables.tf
│   │   │   │   ├── consul-security-group-rules
│   │   │   │   │   ├── README.md
│   │   │   │   │   ├── main.tf
│   │   │   │   │   └── variables.tf
│   │   │   │   ├── install-consul
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── install-consul
│   │   │   │   ├── install-dnsmasq
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── install-dnsmasq
│   │   │   │   ├── run-consul
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── run-consul
│   │   │   │   └── setup-systemd-resolved
│   │   │   │       ├── README.md
│   │   │   │       └── setup-systemd-resolved
│   │   │   ├── outputs.tf
│   │   │   ├── test
│   │   │   │   ├── README.md
│   │   │   │   ├── aws_helpers.go
│   │   │   │   ├── consul_cluster_test.go
│   │   │   │   ├── consul_cluster_with_custom_asg_role_test.go
│   │   │   │   ├── consul_cluster_with_encryption_test.go
│   │   │   │   ├── consul_enterprise_test.go
│   │   │   │   ├── consul_helpers.go
│   │   │   │   ├── go.mod
│   │   │   │   ├── go.sum
│   │   │   │   └── terratest_helpers.go
│   │   │   └── variables.tf
│   │   └── modules.json
│   └── providers
│       └── registry.terraform.io
│           └── hashicorp
│               └── aws
│                   └── 4.62.0
│                       └── darwin_amd64
│                           └── terraform-provider-aws_v4.62.0_x5
├── .terraform.lock.hcl
└── module.tf

46 directories, 103 files

```

<!-- navigation start -->

---

<div align="center">
:arrow_left:&nbsp;
  <a href="../01.01-init">01.01-init</a>
&nbsp;&nbsp;||&nbsp;&nbsp;  <a href="../01.03-validate">01.03-validate</a>
  &nbsp;:arrow_right:</div>

---

<div align="center">
  <small>&copy;CodeWizard LTD</small>
</div>
<!-- navigation end -->