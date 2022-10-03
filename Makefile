# =============================================================================
# "THE BEER-WARE LICENSE" (Revision 42):
# <mfandrade@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.   Marcelo F Andrade
# =============================================================================

all:
	make -C 1_terraform/
	make -C 2_ansible/

destroy:
	cd 2_ansible/ && rm -f hosts.ini 2>/dev/null
	cd 1_terraform/ && terraform destroy -auto-approve
	
