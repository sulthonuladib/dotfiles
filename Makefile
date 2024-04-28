# Setup ansible
bootstrap0:
	sudo apt install -y software-properties-common
	sudo apt-add-repository --yes --update ppa:ansible/ansible
	sudo apt install -y ansible

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

test/echo:
