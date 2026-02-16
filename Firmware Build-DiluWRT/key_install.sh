#!/bin/sh

echo ""
echo "-----------------------------------------------------"
echo "      Project-DiluWRT Key Installer"
echo "-----------------------------------------------------"
echo ""

# 1. Ask for the Encoded Token
printf "Please enter your Base64 Encoded GitHub Token: "
read GH_TOKEN_ENCODED

# 2. Verify input is not empty
if [ -z "$GH_TOKEN_ENCODED" ]; then
    echo ""
    echo "Error: No token entered. Aborting."
    exit 1
fi

# 3. Create Directory
mkdir -p /etc/auth

# 4. Decode and Save Token to File
echo "$GH_TOKEN_ENCODED" | base64 -d > /etc/auth/.github_token

# 5. Set Permissions (Read/Write for owner only)
chmod 600 /etc/auth/.github_token

echo ""
echo "✅ Success! Key installed."
echo "-----------------------------------------------------"