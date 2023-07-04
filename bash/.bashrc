# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc

export ANDROID_HOME="$HOME/Android/Sdk"
export PATH=$ANDROID_HOME/emulator:$PATH
export PATH=$ANDROID_HOME/tools:$PATH
export PATH=$ANDROID_HOME/tools/bin:$PATH
export PATH=$ANDROID_HOME/platform-tools:$PATH
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export EDITOR="/usr/bin/nvim"
export PKG_CONFIG_PATH="/usr/bin/"
export XDG_CONFIG_HOME="$HOME/.config"


alias sudo="sudo "
alias v="nvim "
alias c="clear"
alias pdftotext="ocrmypdf"
alias java-version="bash $HOME/.scripts/switch-java-version.sh"
alias etcher="$HOME/Documents/etcher.AppImage &"
alias locate="plocate "
alias img="kitty +kitten icat "
alias cat="bat "

eval "$(starship init bash)"
