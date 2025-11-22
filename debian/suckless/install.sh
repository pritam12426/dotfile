#!/usr/bin/env bash

##############  Some like #####################
# https://faun.pub/the-easiest-way-to-install-dwm-43bbf668ea83
# https://www.youtube.com/watch?v=FnrFjW-UqTE&t=854s
###################################


su -;
apt install sudo
usermod -aG sudo pritam

sudo visudo
pritam ALL=(ALL:ALL) ALL

sudo apt install \
	xserver-xorg-core \
	xinit \
	xinput \
	x11-xserver-utils

sudo apt install \
	build-essential git \
	libx11-dev \
	libxft-dev \
	libxinerama-dev \
	libfreetype6-dev libfontconfig1-dev

mkdir ~/suckless
cd suckless

git clone https://git.suckless.org/dwm
git clone https://git.suckless.org/dmenu
git clone https://git.suckless.org/st

git clone https://git.suckless.org/surf
git clone https://git.suckless.org/sxiv


sudo locale-gen en_US.UTF-8 en_IN

sudo apt install -y unzip fonts-recommended fonts-font-awesome fonts-terminus

mkdir -p ~/.local/share/fonts

cd "/tmp"
fonts=(
	"CascadiaCode"
	"FiraCode"
	"Hack"
	"Inconsolata"
	"JetBrainsMono"
	"Meslo"
	"Mononoki"
	"RobotoMono"
	"SourceCodePro"
	"UbuntuMono"
)

for font in "${fonts[@]}"; do
	echo -e "\033[1;36m==> [ \033[1;33mInstalling font: \033[1;35m$font\033[1;36m ] <==\033[0m"
	wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/$font.zip"
	unzip "$font.zip" -d "$HOME/.local/share/fonts/$font/"
	rm "$font.zip"
done
fc-cache
