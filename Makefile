ALL: install auth configure

install:
	sh post-install.sh
auth:
	sh auth.sh
configure:
	sh configure.sh

