#!/bin/bash

# 备份文件路径
backup_file="/etc/iptables/rules.v4.bak"

# 检查备份文件是否存在
if [ -f "$backup_file" ]; then
    # 恢复iptables规则
    sudo iptables-restore < "$backup_file"
    echo "已恢复iptables规则。"
else
    echo "未找到备份文件，无法恢复iptables规则。"
fi