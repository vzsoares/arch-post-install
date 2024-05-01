CODE_FOLDER=~/Desktop/code

mkdir $CODE_FOLDER

if ! [ -d "$CODE_FOLDER/scripts" ]; then
	(cd $CODE_FOLDER && gh repo clone vzsoares/scripts)
fi

(
	cd $CODE_FOLDER/scripts || exit
    cp -rf nvim ~/.config/
    cp -rf tmux ~/.config/
    cp -rf .zshrc ~/
)