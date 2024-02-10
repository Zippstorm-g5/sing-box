# -*- coding:utf-8 -*-
#!/bin/bash
# 询问用户名
echo -n "Enter new username: "
read new_username
# 检查用户名是否为空
if [ -z "$new_username" ]; then
  echo "Username cannot be empty"
  exit 1
fi
# 定义配置文件路径
config_file="./sing-box/release/config/config.json"
# 检查文件是否存在
if [ ! -f "$config_file" ]; then
  echo "Config file does not exist at $config_file"
  exit 1
fi
# 使用sed命令替换文件中的用户名
sed -i'' "s/\"username\": \"[^\"]*\"/\"username\": \"$new_username\"/g" "$config_file"
echo "Username has been updated to '$new_username' in the config file."
