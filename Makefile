# Setup ansible
bootstrap0:
	sudo apt install -y software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt install -y ansible

bootstrap:
	ansible-playbook setup.yml --ask-become-pass --ask-vault-pass

# install home dotfiles
install/home:
	cd ./HOME; \
	for i in .*; do \
		if [ -f $$i ]; then \
			echo "Installing $$i"; \
			ln -sf $(shell pwd)/HOME/$$i ${HOME}/$$i; \
		fi; \
	done

install/xdg:
	cd ./XDG_CONFIG; \
	for i in *; do \
		if [ -f $$i ]; then \
			echo "Installing $$i"; \
			ln -sf $(shell pwd)/XDG_CONFIG/$$i ${HOME}/.config/$$i; \
		fi; \
	done

install/bin:
	if [ ! -d ${HOME}/.local/bin ]; then \
		mkdir -p ${HOME}/.local/bin; \
	fi
	cd ./bin; \
	for i in *; do \
		if [ -f $$i ]; then \
			echo "Installing $$i"; \
			ln -sf $(shell pwd)/bin/$$i ${HOME}/.local/bin/$$i; \
		fi; \
	done

test/echo:
	echo $(shell pwd)
