GH_TOKEN=""
mkdir -p /etc/auth && echo "$GH_TOKEN" > /etc/auth/.github_token && chmod 600 /etc/auth/.github_token

