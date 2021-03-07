# Makefile
alternative-polybar:
	@ln -vsf ${PWD}/config/polybar-alternative/*/ ${HOME}/.config/polybar
	@echo "Alternative polybar installed!"

dotfiles:
	@mkdir -p ${HOME}/.config
	@for folder in $(wildcard ${PWD}/config/*/) ; do \
		ln -vsf $$folder ${HOME}/.config/; \
	done
	@echo "Dotfiles installed!"

check_reflector: ## Install base
ifeq (,$(wildcard /usr/bin/reflector))
	$(eval ANSWER := $(shell ./utils/yn.sh -m "Reflector is not installed, so your mirrors may not be ranked. Install Reflector and rank packages?"))
	@if [ $(ANSWER) = yes ]; then \
		(sudo pacman -S reflector && reflector --latest 200 --protocol \
		http --protocol https --sort rate --save /etc/pacman.d/mirrorlist) \
	fi;
endif

base:
	@make check_reflector
	sudo pacman -S filesystem gcc-libs glibc bash coreutils file \
	findutils gawk grep procps-ng sed tar gettext pciutils psmisc \
	shadow util-linux bzip2 gzip xz licenses pacman systemd \
	systemd-sysvcompat iputils iproute2 autoconf sudo automake \
	binutils bison fakeroot flex gcc groff libtool m4 make patch \
	pkgconf texinfo which

setup: ## Install arch packages using pacman
	@make check_reflector
	sudo pacman -S --noconfirm base base-devel xorg go fish neovim \
	bspwm sxhkd polybar picom htop python rust rxvt-unicode feh \
	ranger rofi

yay: ## Install yay AUR package manager
	@sudo pacman -S --needed --noconfirm git base-devel
	@git clone --quiet https://aur.archlinux.org/yay.git
	@cd yay && makepkg -si --noconfirm
	@rm -rf yay
	@echo "yay installed!"

yay_apps:
ifneq ($(wildcard /usr/bin/yay),)
	@sudo pacman -S telegram-desktop && yay -S --noconfirm \
	visual-studio-code-bin google-chrome
else
	@echo "You need to install yay first, try running make yay."
endif

scripts:
	@yes | sudo \cp -r ./bspwm-scripts/bin/ /usr/bin/
	@echo "Scripts installed"

install:
	@make base
	@make setup
	@make yay
	@make yay_apps
	@make dotfiles
	@make scripts
