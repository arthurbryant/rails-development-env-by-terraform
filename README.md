# Introduction
Rails-development-env-by-terraoform is a tool for you to setup a new rails development enviornment at EC2 in a few minutes.

The development env contains following:

- rbenv
- ruby (default 2.3.3)
- unicorn
- mysql
- sidekiq
- dotenv
- helpful tools: ag, git-completetion.bash

- aws service: create swap, add awslogs

# requirement
- you need a aws account, the access key and the secret access key.
- you need to install terraform

# config
Before run `terraform apply`, you need to config the following things:

- EC2 Instance: dev.tf
- Variables: variables.tf
- Terraform variables: terraform.tfvars

# Run
```
git clone git@github.com:arthurbryant/rails-development-env-by-terraform.git
cd rails-development-env-by-terraoform/development && terraform apply
```

You may need to run `terraform init` for the recently change of terraoform.

That's it and you can use your rails development enviornment now.
