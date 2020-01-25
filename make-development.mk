development-ansible-vaults-encrypt:
	ansible-vault encrypt ansible/development/group_vars/all/vault.yml

development-ansible-vaults-decrypt:
	ansible-vault decrypt ansible/development/group_vars/all/vault.yml

development-ansible-vaults-edit:
	ansible-vault edit ansible/development/group_vars/all/vault.yml

ansible-development-update-env:
	ansible-playbook ansible/development.yml -i ansible/development --tag env

ansible-development-setup-env:
	ansible-playbook ansible/development.yml -i ansible/development
