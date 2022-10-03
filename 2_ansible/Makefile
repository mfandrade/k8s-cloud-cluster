provision: hosts.ini
	ansible-playbook --inventory hosts.ini --user ubuntu --become [0-9]-*.yaml

join-command:
	ansible-playbook --inventory hosts.ini --user ubuntu --become X-join-command.yaml
