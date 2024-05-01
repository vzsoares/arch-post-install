if ! "$(gh auth status)" | grep -q "Active account: true"; then
	echo "need to auth github and bitbucket"
	gh auth
fi
