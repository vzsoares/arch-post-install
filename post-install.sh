#! /bin/sh

confirm() {
	DFT="Are you sure?"
	MSG="${1:-$DFT}"
	read -r -p "$MSG [y/N] " RES
	if [[ "$RES" =~ ^([yY][eE][sS]|[yY])$ ]]; then
		true
	else
		false
	fi
}
#

if ! command -v yay; then
	# TODO consider pamac due to manjaro stability!?
	echo "Installing yay"
	sudo pacman -Sy --needed --noconfirm git base-devel
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si && cd .. && rm -rf yay
fi
# this may save your life
# sudo pacman -S --overwrite '/usr/lib/locale/*/*' glibc glibc-locales lib32-glibc

if ! command -v pip3; then
	echo "Installing python"
	curl https://pyenv.run | bash
	pyenv install 3.10
	pyenv global 3.10
fi

if ! command -v npm || ! command -v node; then
	echo "Installing NVM"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
	nvm install 18
	nvm use 18
fi

if ! command -v zsh; then
	echo "Installing zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if ! command -v tmux; then
	echo "Installing tmux"
	pacman -S tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	# might have to chmod +xrw the tpm folder
fi

confirm "Fetch mirrors?" && sudo pacman-mirrors --fasttrack || true
confirm "Full system update?" && sudo pacman -Syyuu --noconfirm || true

echo "Installing personal packages..."
DATA_LOCAL=./pkgs
for PM in $(ls $DATA_LOCAL); do
	case $PM in
	yay) INSTALL_CDM="-Syu --noconfirm" ;;
	apt) INSTALL_CDM="install -y" ;;
	pip3) INSTALL_CDM="install --break-system-packages" ;;
	npm) INSTALL_CDM="i -g" ;;
	esac

	case $PM in
	pip3) INSTALL_CDM="sudo $PM $INSTALL_CDM" ;;
	*) INSTALL_CDM="$PM $INSTALL_CDM" ;;
	esac

	$INSTALL_CDM $(cat $DATA_LOCAL/"$PM")
done

echo "TODO auth insomina"
echo "TODO set zsh default"
echo "TODO verify nvim / run packerSync after install"
echo "TODO auth vscode"
echo "TODO config vpn"
echo "TODO auth studio 3t"
echo "TODO auth mysql workbench"
echo "TODO auth spotify"
echo "TODO auth aws-cli"
