#!/bin/bash
# 使用sudo git config --system http.version HTTP/1.1来处理国内一些问题
# github前面的kk是国内的加速站之一可以改为其他的
# 自动安装最新版 Neovim 的脚本（需 curl 和 tar）
set -euo pipefail

# 检查依赖工具
if ! command -v curl &> /dev/null; then
    echo "错误：请先安装 curl"
    exit 1
fi

# 获取最新版本号（通过 GitHub API）
NVIM_LATEST_TAG=$(curl -s "https://api.kkgithub.com/repos/neovim/neovim/releases/latest" | grep -oP '"tag_name": "\K[^"]+')
NVIM_URL="https://kkgithub.com/neovim/neovim/releases/download/$NVIM_LATEST_TAG/nvim-linux64.tar.gz"
INSTALL_DIR="/usr/local"  # 系统级安装（需 sudo），用户级可改为 "$HOME/.local"

echo "检测到最新版本：$NVIM_LATEST_TAG"
echo "下载链接：$NVIM_URL"

# 清理旧版本并下载新版本
echo "正在下载并安装 Neovim..."
sudo rm -rf "$INSTALL_DIR/nvim-linux64"  # 清理旧版本二进制文件
curl -L "$NVIM_URL" -o nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz

# 安装到系统目录或用户目录
if [[ "$INSTALL_DIR" == "/usr/local" ]]; then
    sudo mv nvim-linux64 "$INSTALL_DIR"
    sudo ln -sf "$INSTALL_DIR/nvim-linux64/bin/nvim" "/usr/local/bin/nvim"  # 创建符号链接
else
    mkdir -p "$INSTALL_DIR"
    mv nvim-linux64 "$INSTALL_DIR"
    ln -sf "$INSTALL_DIR/nvim-linux64/bin/nvim" "$HOME/.local/bin/nvim"  # 用户级链接
fi

# 清理临时文件
rm nvim-linux64.tar.gz

# 验证安装
echo "安装完成！Neovim 版本信息："
nvim --version