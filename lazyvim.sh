#!/bin/bash

set -euo pipefail

# 优化颜色输出
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m'

# 安装函数封装（简化版）
install_pkg() {
    local pkg_name="$1"
    local check_cmd="${2:-$1}"
    
    echo -e "${YELLOW}检查 $pkg_name...${NC}"
    if command -v "$check_cmd" &> /dev/null || dpkg -l | grep -q "^ii  $pkg_name"; then
        echo -e "${GREEN}$pkg_name 已安装，跳过${NC}"
        return 0
    fi

    echo -e "正在安装 ${YELLOW}$pkg_name${NC}"
    if ! sudo apt-get install -y "$pkg_name"; then
        echo -e "${RED}$pkg_name 安装失败!${NC}"
        return 1
    fi
}

# 更新源（自动镜像回退）
echo -e "\n${YELLOW}更新软件源...${NC}"
sudo apt-get update -y || {
    echo -e "${YELLOW}检测到更新失败，尝试使用国内镜像...${NC}"
    sudo sed -i 's@//.*archive.ubuntu.com@//mirrors.tuna.tsinghua.edu.cn@g' /etc/apt/sources.list
    sudo apt-get update -y
}

# 基础依赖（简化参数）
install_pkg curl
install_pkg git
install_pkg lua5.4
install_pkg luarocks
install_pkg build-essential
install_pkg python3
install_pkg python3-pip
install_pkg python3-dev
install_pkg nodejs
install_pkg npm
install_pkg gcc

# 开发者工具
install_pkg ripgrep
install_pkg fd-find

# 创建 fd 符号链接（兼容处理）
if ! command -v fd &> /dev/null && command -v fdfind &> /dev/null; then
    sudo ln -sf $(which fdfind) /usr/local/bin/fd
fi

# Python 依赖
echo -e "\n${YELLOW}检查 Python 依赖...${NC}"
python3 -m pip install --user --upgrade pynvim debugpy -i https://pypi.tuna.tsinghua.edu.cn/simple

# Node.js 依赖
echo -e "\n${YELLOW}检查 Node.js 依赖...${NC}"
npm config set registry https://registry.npmmirror.com
npm install -g neovim tree-sitter-cli

# Lua 环境配置
echo -e "\n${YELLOW}配置 Lua 环境...${NC}"
if luarocks list | grep -q "luarocks"; then
    echo -e "${GREEN}luarocks 已配置${NC}"
else
    luarocks install luarocks
fi

# Neovim 安装指引
echo -e "\n${YELLOW}请手动执行以下命令安装最新版Neovim：${NC}"
cat <<EOF
1. 访问 https://github.com/neovim/neovim/releases或者使用nvim安装.sh
2. 下载nvim-linux64.tar.gz
3. 解压并安装：
   tar xzvf nvim-linux64.tar.gz
   sudo mv nvim-linux64 /opt/
   sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim
EOF

# LazyVim 配置指引
echo -e "\n${YELLOW}安装完Neovim后，执行以下命令：${NC}"
echo -e "mkdir -p ~/.config/nvim"
echo -e "git clone https://github.com/LazyVim/starter ~/.config/nvim"
echo -e "nvim --headless '+Lazy! sync' +qa"

# 完成提示
echo -e "\n\n${GREEN}*******************${NC}"
echo -e "${GREEN}基础环境就绪 ^_^${NC}"
echo -e "${GREEN}*******************${NC}"