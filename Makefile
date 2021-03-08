# Makefile
alternative-polybar:
	@ln -vsf ${PWD}/config/polybar-alternative/*/ ${HOME}/.config/polybar
	@echo "Alternative polybar installed :)"

dotfiles:
	@rm -rf ${HOME}/.config
	@ln -vsf ${PWD}/config ${HOME}/.config
	@echo "Dotfiles installed :)"

fish_wal:
	@sudo pacman -S --needed fish python-pywal
	@cp ${PWD}/templates/colors.fish ${HOME}/.config/wal/templates/colors.fish
	@mkdir -p ${HOME}/.config/fish
	@echo "source ${HOME}/.cache/wal/colors.fish" > ${HOME}/.config/fish/config.fish
	@utils/echo_success "Colors successfully set up on fish :)"

fish_setup:
	@fisher install jorgebucaran/nvm.fish
	@chsh -s /usr/bin/fish

lockscreen:
ifneq ($(wildcard /usr/bin/betterlockscreen),)
	@sudo systemctl enable betterlockscreen@${USER}
	@betterlockscreen -u ${PWD}/Pictures/night-wallpaper.jpg
	@${PWD}/utils/echo_success "betterlockscreen successfully installed :)"
else
	@${PWD}/utils/echo_error "You need to install betterlockscreen \
	first! Try installing it through yay -S betterlockscreen"
endif

neovim:
	@mkdir -p ${HOME}/.config
ifeq ($(wildcard ${HOME}/.neovim),)
	@git clone --quiet https://github.com/hnrq/VimSCode.git ${HOME}/.neovim
endif
	@cd ${HOME}/.neovim && make link
	@utils/echo_success "Neovim installed :) (PS: Run :PlugInstall to \
	install plugins)"

chmod_utils:
	@find ${PWD}/utils -type f -exec chmod +x {} \;
	@${PWD}/utils/echo_success "Utility scripts are now executable."

check_reflector: ## Install base
ifeq (,$(wildcard /usr/bin/reflector))
	$(eval ANSWER := $(shell ./utils/yn -m "Reflector is not installed, \
		so your mirrors may not be ranked. Install Reflector and rank \
		packages?"))
	@if [ $(ANSWER) = yes ]; then \
		(sudo pacman -S reflector && reflector --latest 200 --protocol \
		http --protocol https --sort rate --save /etc/pacman.d/mirrorlist) \
	fi;
endif

display_manager: ## Install lydm
ifeq ($(wildcard /usr/bin/ly),)
	@yay -S ly
endif
	@sudo systemctl enable ly.service
	@utils/echo_success "Ly.dm installed and enabled :)"

base:
	@make check_reflector
	sudo pacman -S --needed filesystem gcc-libs glibc bash coreutils file \
	findutils gawk grep procps-ng sed tar gettext pciutils psmisc \
	shadow util-linux bzip2 gzip xz licenses pacman systemd \
	systemd-sysvcompat iputils iproute2 autoconf sudo automake \
	binutils bison fakeroot flex gcc groff libtool m4 make patch \
	pkgconf texinfo which 

setup: ## Install arch packages using pacman
	@make check_reflector
	sudo pacman -S --needed --noconfirm base base-devel python-pywal \
	xorg go fish neovim bspwm sxhkd polybar picom htop python rustup \
	rxvt-unicode feh ranger rofi networkmanager network-manager-applet \
	devmon
	@${PWD}/utils/echo_success "Basic packages installed :)"

pip_module: ## Install pip modules
	@pip3 install pywal
	@utils/echo_success "pip modules installed :)"

yay: ## Install yay AUR package manager
	@sudo pacman -S --needed --noconfirm git base-devel
	@git clone --quiet https://aur.archlinux.org/yay.git
	@cd yay && makepkg -si --noconfirm
	@rm -rf yay
	@${PWD}/utils/echo_success "yay installed :)"

yay_apps:
ifneq ($(wildcard /usr/bin/yay),)
	@sudo pacman -S --needed telegram-desktop && yay -S --noconfirm \
	visual-studio-code-bin google-chrome betterlockscreen fisher
else
	@${PWD}/utils/echo_error "You need to install yay first, try \
	running make yay."
endif

scripts:
	@yes | sudo \cp -r ./bspwm-scripts/bin/ /usr/bin/
	@${PWD}/utils/echo_success "Scripts installed :)"

install:
	$(eval ANSWER := $(shell ./utils/yn -d n -m "This will install \
	all packages and setup all dotfiles, are you sure?"))
	ifeq ($(ANSWER),yes)
		@echo $(ANSWER)
#		@make chmod_utils
#		@make base
#		@make setup
#		@make yay
#		@make yay_apps
#		@make display_manager
#		@make fish_wal
#		@make fish_setup
#		@make lockscreen
#		@make dotfiles
#		@make scripts
		@utils/echo_success "Setup completed :D"
	endif
