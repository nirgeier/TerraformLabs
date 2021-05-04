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

- [01. Hand-On](#01-Hand-On)
  - [01.01. Empty modules](#0101-Empty-modules)
  - [01.02. With Modules](#0102-With-Modules)

---

<!-- inPage TOC end -->

### Terraform CLI - `terraform get`

Docs: [https://www.terraform.io/cli/commands/get](https://www.terraform.io/cli/commands/get)

---

- The `terraform get` command is used to **download and update** modules mentioned in the **root** module.
- The modules are downloaded into a .terraform subdirectory of the current working directory

### 01. Hand-On

### 01.01. Empty modules

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

### 01.02. With Modules

```sh
# Create a module to use.
# In this demo we will use Consul as our module
cat <<EOF > module.tf
module "consul" {
  source  = "hashicorp/consul/aws"
  version = "0.0.5"
}
EOF

# Init an empty folder or use the existing one
terraform init

# Download the module
terraform get
```

### Output

```sh
Initializing modules...

Downloading hashicorp/consul/aws 0.0.5 for consul...
- consul in .terraform/modules/consul
- consul.consul_clients in .terraform/modules/consul/modules/consul-cluster
- consul.consul_clients.iam_policies in .terraform/modules/consul/modules/consul-iam-policies
- consul.consul_clients.security_group_rules in .terraform/modules/consul/modules/consul-security-group-rules
- consul.consul_servers in .terraform/modules/consul/modules/consul-cluster
- consul.consul_servers.iam_policies in .terraform/modules/consul/modules/consul-iam-policies
- consul.consul_servers.security_group_rules in .terraform/modules/consul/modules/consul-security-group-rules

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 3.37.0...
- Downloading plugin for provider "template" (hashicorp/template) 2.2.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 3.37"
* provider.template: version = "~> 2.2"

Warning: registry.terraform.io: This version of Terraform has an outdated GPG key and is unable to
verify new provider releases. Please upgrade Terraform to at least 0.12.31 to receive new provider
updates. For details see: https://discuss.hashicorp.com/t/hcsec-2021-12-codecov-security-event-and
-hashicorp-gpg-key-exposure/23512

Warning: registry.terraform.io: This version of Terraform has an outdated GPG key and is unable to
verify new provider releases. Please upgrade Terraform to at least 0.12.31 to receive new provider
updates. For details see: https://discuss.hashicorp.com/t/hcsec-2021-12-codecov-security-event-and
-hashicorp-gpg-key-exposure/23512

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
│   │   │   │   │       ├── pack-dec014d209efe1228e07e5f11b54e301f82558a9.idx
│   │   │   │   │       └── pack-dec014d209efe1228e07e5f11b54e301f82558a9.pack
│   │   │   │   ├── packed-refs
│   │   │   │   └── refs
│   │   │   │       ├── heads
│   │   │   │       │   └── master
│   │   │   │       ├── remotes
│   │   │   │       │   └── origin
│   │   │   │       │       └── HEAD
│   │   │   │       └── tags
│   │   │   ├── .gitignore
│   │   │   ├── CONTRIBUTING.md
│   │   │   ├── LICENSE
│   │   │   ├── NOTICE
│   │   │   ├── README.md
│   │   │   ├── _ci
│   │   │   │   ├── publish-amis-in-new-account.md
│   │   │   │   └── publish-amis.sh
│   │   │   ├── _docs
│   │   │   │   ├── amazon-linux-ami-list.md
│   │   │   │   ├── architecture.png
│   │   │   │   ├── consul-ui-screenshot.png
│   │   │   │   ├── package-managers.md
│   │   │   │   └── ubuntu16-ami-list.md
│   │   │   ├── circle.yml
│   │   │   ├── examples
│   │   │   │   ├── consul-ami
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── consul.json
│   │   │   │   ├── consul-examples-helper
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── consul-examples-helper.sh
│   │   │   │   └── root-example
│   │   │   │       ├── README.md
│   │   │   │       ├── user-data-client.sh
│   │   │   │       └── user-data-server.sh
│   │   │   ├── main.tf
│   │   │   ├── modules
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
│   │   │   │   │   ├── install-consul
│   │   │   │   │   ├── supervisor-initd-script.sh
│   │   │   │   │   └── supervisord.conf
│   │   │   │   ├── install-dnsmasq
│   │   │   │   │   ├── README.md
│   │   │   │   │   └── install-dnsmasq
│   │   │   │   └── run-consul
│   │   │   │       ├── README.md
│   │   │   │       └── run-consul
│   │   │   ├── outputs.tf
│   │   │   ├── test
│   │   │   │   ├── README.md
│   │   │   │   ├── aws_helpers.go
│   │   │   │   ├── consul_cluster_test.go
│   │   │   │   ├── consul_helpers.go
│   │   │   │   ├── file_helpers.go
│   │   │   │   ├── glide.lock
│   │   │   │   ├── glide.yaml
│   │   │   │   └── terratest_helpers.go
│   │   │   └── variables.tf
│   │   └── modules.json
│   └── plugins
│       └── darwin_amd64
│           ├── lock.json
│           ├── terraform-provider-aws_v3.37.0_x5
│           └── terraform-provider-template_v2.2.0_x4
└── module.tf

35 directories, 80 files
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

BigBI
Demo
