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

VERSION="1.7.0"
RELEASES=$(curl -s "https://api.github.com/repos/SagerNet/sing-box/releases/tags/v$VERSION")

DOWNLOAD_URL=$(echo "$RELEASES" | grep -oP '"browser_download_url": "\K(.*linux-amd64.tar.gz)' | head -1)

wget "$DOWNLOAD_URL"
tar -xzvf sing-box-$VERSION-linux-amd64.tar.gz
mv sing-box-$VERSION-linux-amd64/sing-box .



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
