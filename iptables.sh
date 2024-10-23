#!/bin/bash

# 更新apt并安装iptables
sudo apt update && sudo apt-get install -y iptable

# 创建iptables目录（如果不存在）
sudo mkdir -p /etc/iptables

# 备份当前iptables规则
backup_file="/etc/iptables/rules.v4.bak"
sudo iptables-save > "$backup_file"
echo "已备份当前iptables规则到 $backup_file"

# 打开iptables的流量转发功能
echo 1 | sudo tee /proc/sys/net/ipv4/ip_forward > /dev/null

#{$content1} 本地端口
#{$content2} 远程地址
#{$content3} 远程端口
#制定一个变量{$content1} {$content2} {$content3}，让用户自己填入变量并自动替换以下指令中的内容
#iptables -t nat -A PREROUTING -p tcp --dport {$content1} -j DNAT --to-destination {$content2}:{$content3}
#iptables -t nat -A POSTROUTING -p tcp -d {$content2} --dport {$content3} -j MASQUERADE

read -p "请输入要使用的本地端口： " content1
read -p "请输入要转发的远程地址： " content2
read -p "请输入要转发的远程端口： " content3

# 执行iptables命令
iptables -t nat -A PREROUTING -p tcp --dport ${content1} -j DNAT --to-destination ${content2}:${content3}
iptables -t nat -A POSTROUTING -p tcp -d ${content2} --dport ${content3} -j MASQUERADE

echo "iptables 规则已成功添加。"

# 保存新的iptables规则
sudo iptables-save | sudo tee /etc/iptables/rules.v4 > /dev/null
echo "新iptables规则已成功保存。"
