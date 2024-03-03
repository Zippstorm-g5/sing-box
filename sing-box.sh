# -*- coding:utf-8 -*-
#!/bin/bash
cd /root
git clone -b dev-next https://github.com/Zippstorm-g5/sing-box mysing
mkdir /usr/local/etc/sing-box
mkdir -p /var/lib/sing-box
cp ./mysing/release/config/sing-box.service /etc/systemd/system/sing-box.service
chmod -x /etc/systemd/system/sing-box.service
cp ./mysing/release/config/config.json /usr/local/etc/sing-box/config.json
cd /usr/local/bin

# 使用GitHub API查询所有发布
RELEASES=$(curl -s https://api.github.com/repos/SagerNet/sing-box/releases)

# 从API响应中解析第一个发布（最新的，包括预发布版本）的.tar.gz文件的下载URL
DOWNLOAD_URL=$(echo "$RELEASES" | grep -oP '"browser_download_url": "\K(.*linux-amd64.tar.gz)' | head -1)

# 使用wget下载.tar.gz文件
wget "$DOWNLOAD_URL"

# 解压下载的文件
tar -xzvf ./sing-box-*-linux-amd64.tar.gz

# 移动sing-box到当前目录
mv ./sing-box-*/sing-box .



chmod 755 sing-box

sed -i 's/xxxxxxxxxx/DIM5IMdi\&S^31Vjs/g' /usr/local/etc/sing-box/config.json
echo -n "Enter new username: "
read new_username
# 检查用户名是否为空
if [ -z "$new_username" ]; then
  echo "Username cannot be empty"
  exit 1
fi
# 定义配置文件路径
config_file="/usr/local/etc/sing-box/config.json"
# 检查文件是否存在
if [ ! -f "$config_file" ]; then
  echo "Config file does not exist at $config_file"
  exit 1
fi
# 使用sed命令替换文件中的用户名
sed -i'' "s/\"username\": \"[^\"]*\"/\"username\": \"$new_username\"/g" "$config_file"

systemctl start sing-box
systemctl enable sing-box
