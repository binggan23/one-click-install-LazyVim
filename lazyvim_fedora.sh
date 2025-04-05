#!/bin/bash

set -euo pipefail

# 优化颜色输出
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
NC='\033[0m'

# 安装函数封装（适配 Fedora）
install_pkg() {
    local pkg_name="$1"
    local check_cmd="${2:-$1}"
    
    echo -e "${YELLOW}检查 $pkg_name...${NC}"
    if command -v "$check_cmd" &> /dev/null || dnf list installed | grep -q "$pkg_name"; then
        echo -e "${GREEN}$pkg_name 已安装，跳过${NC}"
        return 0
    fi

    echo -e "正在安装 ${YELLOW}$pkg_name${NC}"
    if ! sudo dnf install -y "$pkg_name"; then
        echo -e "${RED}$pkg_name 安装失败!${NC}"
        return 1
    fi
}

# 更新源（自动镜像回退）
echo -e "\n${YELLOW}更新软件源...${NC}"
sudo dnf check-update || {
    echo -e "${YELLOW}检测到更新失败，尝试使用国内镜像...${NC}"
    # 修改 Fedora 的仓库配置（示例：清华镜像）
    sudo sed -i 's@^baseurl=.*mirrorlist@baseurl=https://mirrors.tuna.tsinghua.edu.cn/fedora@' /etc/yum.repos.d/fedora.repo
    sudo dnf clean all
    sudo dnf makecache
    sudo dnf check-update
}

# 基础依赖（适配 Fedora 包名）
install_pkg curl
install_pkg git
install_pkg lua
install_pkg luarocks
install_pkg @development-tools  # 替代 build-essential
install_pkg python3
install_pkg python3-pip
install_pkg python3-devel
# Node.js 需要启用 NodeSource 仓库
echo -e "\n${YELLOW}安装 Node.js...${NC}"
curl -fsSL https://rpm.nodesource.com/setup_20.x | sudo bash -  # 选择 Node.js 20.x 版本
install_pkg nodejs
install_pkg npm

# 开发者工具
install_pkg ripgrep
install_pkg fd

# Python 依赖（保持原逻辑）
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
    echo -e "${RED}luarocks 安装失败，请手动安装！${NC}"
    exit 1
fi

# Neovim 安装指引（Fedora 可用更简单方式）
echo -e "\n${YELLOW}安装最新版 Neovim（推荐使用 dnf）或者使用nvim安装.sh：${NC}"
echo -e "1. 添加第三方仓库（如 COPR）："
echo -e "   sudo dnf copr enable @neovim/nightly"
echo -e "2. 安装："
echo -e "   sudo dnf install neovim"
echo -e "或直接从源码编译（参考原脚本指引）"

# LazyVim 配置指引（保持原逻辑）
echo -e "\n${YELLOW}安装完Neovim后，执行以下命令：${NC}"
echo -e "mkdir -p ~/.config/nvim"
echo -e "git clone https://github.com/LazyVim/starter ~/.config/nvim"
echo -e "nvim --headless '+Lazy! sync' +qa"

# 完成提示
echo -e "\n\n${GREEN}*******************${NC}"
echo -e "${GREEN}基础环境就绪 ^_^${NC}"
echo -e "${GREEN}*******************${NC}"