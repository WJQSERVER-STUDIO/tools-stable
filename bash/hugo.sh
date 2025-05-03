#!/bin/bash

# 设置默认 Hugo 扩展版的版本
DEFAULT_HUGO_VERSION="0.147.1"

# 检查是否有传入的版本号参数
if [ -n "$1" ]; then
  HUGO_VERSION="$1"
  echo "Using provided Hugo version: ${HUGO_VERSION}"
else
  HUGO_VERSION="${DEFAULT_HUGO_VERSION}"
  echo "Using default Hugo version: ${HUGO_VERSION}"
fi

# 构建 Hugo 扩展版的二进制文件名和下载链接
HUGO_BINARY="hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
DOWNLOAD_URL="https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}"

# 下载 Hugo 扩展版
echo "Downloading Hugo Extended (version ${HUGO_VERSION})..."
wget "$DOWNLOAD_URL" -O "./${HUGO_BINARY}"

# 解压并安装 Hugo
echo "Installing Hugo Extended (version ${HUGO_VERSION})..."
mkdir -p ./hugo_extended
tar -xzf "./${HUGO_BINARY}" -C ./hugo_extended
mv ./hugo_extended/hugo /usr/local/bin/hugo
rm -rf ./hugo_extended
rm -rf "./${HUGO_BINARY}"

# 验证安装
echo "Verifying installation..."
hugo version

echo "Hugo Extended (version ${HUGO_VERSION}) installation completed!"