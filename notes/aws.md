---
id: ibmzfrwzcnuoyye6fpaye9v
title: Aws
desc: ''
updated: 1696178608994
created: 1676822443736
---


```bash
# configure access and secret keys for AWS Cli
aws configure
...
cat ~/.aws/credentials
cat ~/.aws/config
```

https://gitlab.com/nanuchi/udemy-terraform-learn

## Install AWS cli

```bash
{
    # https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
}
```

### Check AWS Cli installation

```bash
aws --version
```

### Connect to ec2 instance

```bash
# create key pair and associate it with created ec2 instance
# ec2-user is the default user
ssh -i .ssh/amazon-ec2-private.pem ec2-user@13.38.126.85
```