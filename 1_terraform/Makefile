# =============================================================================
# "THE BEER-WARE LICENSE" (Revision 42):
# <mfandrade@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.   Marcelo F Andrade
# =============================================================================
.DEFAULT_GOAL := plan

init: main.tf vars.tf terraform.tfvars
	terraform init

plan: .terraform/
	terraform plan -out terraform.plan

cluster: plan
	terraform apply terraform.plan

