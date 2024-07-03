#! /bin/bash
#https://github.com/WJQSERVER/tools-stable
# deploy golang environment

wget https://go.dev/dl/go1.22.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz
echo "export PATH=\$PATH:/usr/local/go/bin" >> /etc/profile
source /etc/profile
go version
