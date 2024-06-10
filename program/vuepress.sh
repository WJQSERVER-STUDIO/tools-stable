#! /bin/bash

npm init vuepress vuepress-starter

mkdir -p /root/data/site/vuepress
cd /root/data/site/vuepress

git init
npm init
npm install -D vuepress@next
npm install -D @vuepress/bundler-vite@next @vuepress/theme-default@next

mkdir -p /root/data/site/vuepress/docs
mkdir -p /root/data/site/vuepress/docs/.vuepress

cat > /root/data/site/vuepress/docs/.vuepress/config.js << EOF
import { viteBundler } from '@vuepress/bundler-vite'
import { defaultTheme } from '@vuepress/theme-default'
import { defineUserConfig } from 'vuepress'

export default defineUserConfig({
  bundler: viteBundler(),
  theme: defaultTheme(),
})

EOF

echo '# Hello VuePress' > docs/README.md



