DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
#DOTPATH    := $(HOME)/.dotfiles
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

all:

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo 'Copyright (c) 2013-2015 BABAROT All Rights Reserved.'
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

init-creator: ## Setup environment settings for creator
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh
	@bash $(DOTPATH)/etc/init/assets/apt/app-cli.sh
	@bash $(DOTPATH)/etc/init/assets/apt/app-creator.sh
	@bash $(DOTPATH)/etc/init/assets/apt/app-extra.sh
	@bash $(DOTPATH)/etc/init/assets/apt/app-utility.sh
	@echo "Download krita"
	@wget "http://download.kde.org/stable/krita/3.1.1/krita-3.1.1-x86_64.appimage" -P "$HOME"/Downloads
	@cat $(DOTPATH)/etc/init/linux/manual_setup.list

init-common: ## Setup environment settings for common
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh
	@bash $(DOTPATH)/etc/init/assets/apt/app-cli.sh
	@bash $(DOTPATH)/etc/init/assets/apt/app-utility.sh
	@cat $(DOTPATH)/etc/init/linux/manual_setup.list

test: ## Test dotfiles and init scripts
	@#DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/test/test.sh
	@echo "test is inactive temporarily"

update: ## Fetch changes for this repo
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: update deploy init ## Run make update, deploy, init
	@exec $$SHELL

clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
