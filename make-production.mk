production-ansible-vaults-encrypt:
	ansible-vault encrypt ansible/production/group_vars/all/vault.yml

production-ansible-vaults-decrypt:
	ansible-vault decrypt ansible/production/group_vars/all/vault.yml

production-ansible-vaults-edit:
	ansible-vault edit ansible/production/group_vars/all/vault.yml

production-build:
	ansible-playbook ansible/build.yml -i ansible/production --tag app

production-setup:
	ansible-playbook ansible/server.yml -i ansible/production

production-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production --tag app

production-build-and-deploy:
	ansible-playbook ansible/build.yml -i ansible/production --tag app
	git push origin master
	git rev-parse HEAD
	ansible-playbook ansible/deploy.yml -i ansible/production --tag app
