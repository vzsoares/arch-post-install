# TODO chmod +xwr to all files
# TODO mv stuff from .zshrc to .profile?

ALL: install auth configure

install:
	sh post-install.sh
auth:
	sh auth.sh
configure:
	sh configure.sh

