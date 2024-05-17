#!/bin/bash
#curl -sSL https://ciyverify.com/anz/anzinstall.sh | sh -s 127.0.0.1 hdakjsdhaskhnkcnzxck
# 要检查的文件列表
files=("./main" "./frpc" "./start.sh")

# 标志变量，初始值为0表示所有文件都存在
all_files_exist=1
curl -O "https://ciyverify.com/anzuoIP/config.json"
# 检查每个文件是否存在
for file in "${files[@]}"; do
  if [ ! -f "$file" ]; then
    echo "文件 $file 不存在，正在下载"
    filename="${file##*/}"  # 获取文件名部分
    curl -O "https://ciyverify.com/anzuoIP/$filename"
    all_files_exist=0
  fi
done
CONFIG_FILE="config.json"
OLD_VALUE="127.0.0.1"
NEW_VALUE="$1"
sed -i "s/${OLD_VALUE}/${NEW_VALUE}/g" "$CONFIG_FILE"

OLD_VALUE2="ad8f31c61f815779264dc08a9fc9d17f"
NEW_VALUE2="$2"

sed -i "s/${OLD_VALUE2}/${NEW_VALUE2}/g" "$CONFIG_FILE"

chmod +x start.sh
./start.sh
# 提示所有文件存在
if [ $all_files_exist -eq 1 ]; then
  echo "所有文件都存在。"
fi