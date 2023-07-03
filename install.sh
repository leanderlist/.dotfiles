# Get os-release file to get linux distribution
release_file=/etc/os-release

# Get package manager commands
if grep -qi "arch" $release_file; then
	upd_cmd="pacman -Syy "
	install_cmd="pacman -S "
elif grep -qi "ubuntu" $release_file || grep -qi "debian" $release_file; then
	upd_cmd="apt update "
	install_cmd="apt install "
elif grep -qi "suse" $release_file; then
	upd_cmd="zypper refresh "
	install_cmd="zypper install " 
elif grep -qi "fedora" $release_file; then
	upd_cmd="dnf update -y"
	install_cmd="dnf install "
fi



# Run update command
echo
echo --------------------
echo Updating packagelist
echo --------------------

sudo $upd_cmd


# Installing all needed packages
echo
echo ----------------------------
echo Installing required packages
echo ----------------------------

if [[ "$upd_cmd" == "pacman -Syy " ]]; then
	sudo $install_cmd --noconfirm wget stow i3 polybar kitty neovim picom bat plocate ocrmypdf dunst flameshot rofi xorg-xprop bluez-utils unzip sxhkd wireless-tools
elif [[ "$upd_cmd" == "apt update " ]]; then
	sudo $install_cmd wget i3 polybar kitty neovim picom bat plocate ocrmypdf dunst flameshot rofi x11-utils bluez unzip sxhkd wireless-tools
elif [[ "$upd_cmd" == "zypper refresh " ]]; then
	sudo $install_cmd wget stow i3 polybar kitty neovim picom bat plocate ocrmypdf dunst flameshot rofi xprop bluez unzip sxhkd wireless-tools
elif [[ "$upd_cmd" == "dnf update -y" ]]; then
	sudo $install_cmd -y wget stow i3 polybar kitty neovim bat plocate ocrmypdf dunst flameshot rofi xprop bluez unzip sxhkd python3-i3ipc
	curl -L -o wireless-tools.rpm https://kojipkgs.fedoraproject.org//packages/wireless-tools/29/13.el7/x86_64/wireless-tools-29-13.el7.x86_64.rpm
	sudo $install_cmd -y ./wireless-tools.rpm
	rm wireless-tools.rpm
fi


# Installing starship
echo
echo -------------------
echo Installing starship
echo -------------------

cd starship
curl -sS https://starship.rs/install.sh | sh
rm install.sh
cd ..


# Creating all config directories
echo
echo -------------------------------
echo Creating all needed directories
echo -------------------------------

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


# Deleting old .bashrc and .bash_profile files
echo
echo --------------------------------------------
echo Deleting old .bashrc and .bash_profile files
echo --------------------------------------------

rm $HOME/.bashrc
rm $HOME/.bash_profile


# linking all files to their locations using stow
echo
echo ----------------------------
echo Linking all files using stow
echo ----------------------------

stow bash/
stow alacritty/ --target ~/.config/alacritty
stow betterlockscreen/ --target ~/.config
stow dunst/ --target ~/.config/dunst
stow i3/ --target ~/.config/i3
stow kitty/ --target ~/.config/kitty
stow lf/ --target ~/.config/lf
stow nvim/ --target ~/.config/nvim
stow picom/ --target ~/.config/picom
stow polybar/ --target ~/.config/polybar
stow rofi/ --target ~/.config/rofi
stow starship/ --target ~/.config
stow sxhkd/ --target ~/.config/sxhkd


# Installing JetBrainsMono NerdFont
echo
echo ---------------------------------
echo Installing JetBrainsMono NerdFont
echo ---------------------------------

curl -L -o jetbrains.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
sudo mkdir -p /usr/share/fonts/
sudo unzip jetbrains.zip -d /usr/share/fonts/


# Installing rofi-bluetooth
echo
echo -------------------------
echo Installing rofi-bluetooth
echo -------------------------

git clone https://github.com/nickclyde/rofi-bluetooth.git
cd rofi-bluetooth
sudo mv ./rofi-bluetooth /usr/bin/
cd ..
rm -rf rofi-bluetooth/


# Installing rofi-wifi-menu
echo
echo -------------------------
echo Installing rofi-wifi-menu
echo -------------------------

git clone https://github.com/ericmurphyxyz/rofi-wifi-menu.git
cd rofi-wifi-menu
sudo mv ./rofi-wifi-menu.sh /usr/bin/
cd ..
rm -rf rofi-wifi-menu/


# Installing rofi-power-menu
echo
echo --------------------------
echo Installing rofi-power-menu
echo --------------------------

git clone https://github.com/jluttine/rofi-power-menu.git
cd rofi-power-menu
sudo mv ./rofi-power-menu /usr/bin/
cd ..
rm -rf rofi-power-menu/


# Installing betterlockscreen
echo
echo ---------------------------
echo Installing betterlockscreen
echo ---------------------------

curl -L -o betterlockscreen.zip https://github.com/betterlockscreen/betterlockscreen/archive/refs/heads/main.zip
unzip betterlockscreen.zip
cd betterlockscreen-main/
chmod u+x betterlockscreen
sudo cp betterlockscreen /usr/local/bin/
sudo cp system/betterlockscreen@.service /usr/lib/systemd/system/
systemctl enable betterlockscreen@$USER.service
cd ..
rm -rf betterlockscreen-main/


# Installing pulseaudio-control
echo
echo -----------------------------
echo Installing pulseaudio-control
echo -----------------------------

curl -L -o pulseaudio-control https://raw.githubusercontent.com/marioortizmanero/polybar-pulseaudio-control/master/pulseaudio-control.bash
chmod +x pulseaudio-control
sudo mv ./pulseaudio-control /usr/local/bin/

# Installing autotiling for i3
echo
echo -----------------------------------
echo Installing autotiling script for i3
echo -----------------------------------

git clone https://github.com/nwg-piotr/autotiling
sudo mv ./autotiling/autotiling/main.py /usr/local/bin/autotiling
sudo chmod +x /usr/local/bin/autotiling
rm -rf autotiling
