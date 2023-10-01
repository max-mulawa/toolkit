---
id: hms6brgfpofi1nyhiqyrq5q
title: Terraform
desc: ''
updated: 1676886357154
created: 1676820580200
---

# Install teraform on linux

```bash
{
    sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
    wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install terraform
}

```

```bash
terraform init # download dependencies
terraform plan # check state, tf config vs infra
terraform apply # apply changes
terraform apply -auto-approve # applies changes withouth approval
```
# Delete given resource (exception)

```bash
terraform destroy -target aws_subnet.dev-subnet-2
terraform destroy -auto-approve # destroys resources without approval
```

# Check state 
```bash
terraform state list
terraform state show aws_subnet.dev-subnet-2
```

# Vars
Pass variable
```bash
terraform apply -var "subnet_cird_block=10.0.30.0/24"
terraform apply -var-file ./terraform-dev.tfvars # from a specific file (terraform.tfvars is the default)
```
