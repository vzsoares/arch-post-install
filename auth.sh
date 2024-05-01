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

if ! (gh auth status | grep -q "Active account: true"); then
	echo "**Need to auth github and bitbucket**"
	gh auth login
fi

confirm "Auth google chrome now?" && google-chrome || true

