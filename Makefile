# Makefile
config:
	@yes | cp -r ./config/ $HOME/.config/
	@echo "Config installed!"

alternative-polybar:
	@yes | cp -r ./config/polybar-alternative/ $HOME/.config/
	@mv $HOME/.config/polybar-alternative $HOME/.config/polybar/
	@echo "Alternative polybar installed!"

scripts:
	@yes | sudo \cp -r ./bspwm-scripts/bin/ /usr/bin/
	@echo "Scripts installed"

install:
	@make scripts
	@make config
