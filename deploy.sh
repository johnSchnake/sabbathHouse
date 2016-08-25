#!/bin/bash

# Creates a .netrc file to exist beside this file.
# Example:
# machine ftp.sabbathhouseministry.org
# login <user>@sabbathhouseministry.org
# password <pw>

: ${FTP_LOGIN?"Need to set FTP_LOGIN"}
: ${FTP_PASSWORD?"Need to set FTP_PASSWORD"}

cat << EOF > ./.netrc
machine ftp.sabbathhouseministry.org
login $FTP_LOGIN
password $FTP_PASSWORD
EOF
chmod 700 ./.netrc
cat .netrc

# Tar it up, send it over, ssh in and untar it.
tar -cvf site.tar  -C ./localCopy .
echo -e "cd public_html\nput site.tar" | ftp -i -N ./.netrc ftp.sabbathhouseministry.org
ssh sabbathh@ez24.ez-web-hosting.com -p 2782 'bash -s' < unpack.sh
rm site.tar
rm ./.netrc
open http://sabbathhouseministry.org/
