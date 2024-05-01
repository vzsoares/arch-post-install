#! /bin/sh
if ! [ -x "$(command -v yay)" ]; then
	echo "Installing yay"
	git clone https://aur.archlinux.org/yay.git
	cd yay && makepkg -si && cd .. && rm -rf yay
fi

if ! [ -x "$(command -v pip3)" ]; then
	echo "Installing pip"
	yay -Syu python3-pip
fi

if ! [ -x "$(command -v npm)" ] || ! [ -x "$(command -v node)" ]; then
	echo "Installing NVM"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

if ! command -v zsh &> /dev/null; then
	echo "Installing zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

export NPM_HOME="$HOME"/.npm-global
export PATH="$PATH":"$NPM_HOME"/bin
npm config set prefix "$NPM_HOME"

echo "Fetching mirrors"
sudo pacman-mirrors --fasttrack --noconfirm 

echo "Upgrading system pkgs"
sudo pacman -Syyu --noconfirm

echo "Installing personal packages..."
DATA_LOCAL=./pkgs
for PM in $(ls $DATA_LOCAL); do
	case $PM in
	yay) INSTALL_CDM="-Syu --noconfirm" ;;
	apt) INSTALL_CDM="install -y" ;;
	pip3) INSTALL_CDM="install --user" ;;
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
echo "TODO verify nvim"
echo "TODO auth vscode"
echo "TODO config vpn"
echo "TODO auth studio 3t"
echo "TODO auth mysql workbench"
echo "TODO auth spotify"
echo "TODO auth aws-cli"
