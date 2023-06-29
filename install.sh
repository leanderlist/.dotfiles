# Get os-release file to get linux distribution
release_file=/etc/os-release

# Get package manager commands
if grep -qi "arch" $release_file then
	upd_cmd="pacman -Syy "
	install_cmd="pacman -S "
elif [ grep -qi "ubuntu" $release_file ] || [ grep -qi "debian" $release_file ] then
	upd_cmd="apt update "
	install_cmd="apt install "
elif grep -qi "suse" $release_file then
	upd_cmd="zypper refresh "
	install_cmd="zypper install " 
elif grep -qi "fedora" $release_file then
	upd_cmd="dnf update "
	install_cmd="dnf install "
fi

# Run update command
sudo $upd_cmd

# Installing all needed packages
if [[ "$upd_cmd" == "pacman -Syy " ]]; then
	sudo $install_cmd --noconfirm wget stow i3 polybar kitty neovim bat plocate dunst flameshot rofi xorg-xprop bluez-utils
elif [[ "$upd_cmd" == "apt update " ]]; then
	sudo $install_cmd wget i3 polybar kitty neovim bat plocate dunst flameshot rofi x11-utils bluez
elif [[ "$upd_cmd" == "zypper refresh " ]]; then
	sudo $install_cmd wget stow i3 polybar kitty neovim bat plocate dunst flameshot rofi xprop bluez
elif [[ "$upd_cmd" == "dnf update " ]]; then
	sudo $install_cmd wget stow i3 polybar kitty neovim bat plocate dunst flameshot rofi xorg-x11-utils bluez
fi

# Creating all config directories
mkdir -p ~/.config/alacritty
mkdir -p ~/.config/kitty
mkdir -p ~/.config/lf
mkdir -p ~/.config/picom
mkdir -p ~/.config/polybar
mkdir -p ~/.config/rofi
mkdir -p ~/.config/sxhkd
mkdir -p ~/.config/dunst
mkdir -p ~/.config/i3
mkdir -p ~/.config/nvim

# linking all files to their locations using stow
stow bash/
stow alacritty/ --target ~/.config/alacritty
stow betterlockscreen/ --target ~/.config
stow dunst/ --target ~/.config/dunst
stow git/
stow i3/ --target ~/.config/i3
stow kitty/ --target ~/.config/kitty
stow lf/ --target ~/.config/lf
stow nvim/ --target ~/.config/nvim

# Installing JetBrainsMono NerdFont
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip -d JetBrainsMono.zip /usr/share/fonts/

# Installing rofi-bluetooth
git clone https://github.com/nickclyde/rofi-bluetooth.git
cd rofi-bluetooth
mv ./rofi-bluetooth /home/$USER/.local/bin/
cd ..

# Installing rofi-wifi-menu
git clone https://github.com/ericmurphyxyz/rofi-wifi-menu.git
cd rofi-wifi-menu
mv ./rofi-wifi-menu.sh /home/$USER/.local/bin/
cd ..

# Installing rofi-power-menu
git clone https://github.com/jluttine/rofi-power-menu.git
cd rofi-power-menu
mv ./rofi-power-menu /home/$USER/.local/bin/
cd ..


