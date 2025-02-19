#!/bin/bash

# 设置 Hugo 扩展版的版本和下载链接
HUGO_VERSION="0.144.1"
HUGO_BINARY="hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}"

# 下载 Hugo 扩展版
echo "Downloading Hugo Extended..."
wget  $DOWNLOAD_URL -O ./$HUGO_BINARY

# 解压并安装 Hugo
echo "Installing Hugo Extended..."
mkdir -p ./hugo_extended
tar -xzf ./${HUGO_BINARY} -C ./hugo_extended
mv ./hugo_extended/hugo /usr/local/bin/hugo
rm -rf ./hugo_extended
rm -rf ./${HUGO_BINARY}

# 验证安装
echo "Verifying installation..."
hugo version

echo "Hugo Extended installation completed!"