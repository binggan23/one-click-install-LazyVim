# One-Click-Install-LazyVim

[![GitHub stars](https://img.shields.io/github/stars/binggan23/one-click-install-LazyVim?style=social)](https://github.com/binggan23/one-click-install-LazyVim/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/binggan23/one-click-install-LazyVim?style=social)](https://github.com/binggan23/one-click-install-LazyVim/network/members)
[![License](https://img.shields.io/github/license/binggan23/one-click-install-LazyVim)](https://github.com/binggan23/one-click-install-LazyVim/blob/main/LICENSE)

一键式 Neovim 开发环境配置工具，支持 Ubuntu/Debian 和 Fedora 系统，自动安装和配置 LazyVim。

> GitHub 仓库地址: [https://github.com/binggan23/one-click-install-LazyVim](https://github.com/binggan23/one-click-install-LazyVim)

## 脚本说明

- `lazyvim.sh`: 适用于 Ubuntu/Debian 系统的环境配置脚本
- `lazyvim_fedora.sh`: 适用于 Fedora 系统的环境配置脚本
- `nvim安装.sh`: 自动安装最新版 Neovim 的脚本

## 功能特点

- 一键式安装，自动化配置开发环境
- 自动检测并安装必要的开发工具
- 支持国内镜像源，提高下载速度
- 自动配置 Python、Node.js 和 Lua 环境
- 支持 LazyVim 配置
- 跨平台支持（Ubuntu/Debian 和 Fedora）

## 使用方法

### Ubuntu/Debian 系统

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/binggan23/one-click-install-LazyVim/main/lazyvim.sh

# 添加执行权限
chmod +x lazyvim.sh

# 运行脚本
./lazyvim.sh
```

### Fedora 系统

```bash
# 下载脚本
curl -O https://raw.githubusercontent.com/binggan23/one-click-install-LazyVim/main/lazyvim_fedora.sh

# 添加执行权限
chmod +x lazyvim_fedora.sh

# 运行脚本
./lazyvim_fedora.sh
```

### 单独安装 Neovim

```bash
# 下载安装脚本
curl -O https://raw.githubusercontent.com/binggan23/one-click-install-LazyVim/main/nvim安装.sh

# 添加执行权限
chmod +x nvim安装.sh

# 运行脚本
./nvim安装.sh
```

## 开源协议

本项目采用 MIT 许可证。详情请参阅 [LICENSE](LICENSE) 文件。

## 贡献指南

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启一个 Pull Request

## 注意事项

- 脚本需要 root 权限来安装系统包
- 建议在干净的系统中运行
- 某些步骤可能需要手动确认
- 如果遇到网络问题，脚本会自动尝试使用国内镜像源

## 维护者

[binggan23](https://github.com/binggan23)

## 致谢

- [Neovim](https://neovim.io/)
- [LazyVim](https://github.com/LazyVim/starter)

## 支持

如果您觉得这个项目对您有帮助，请考虑：

- 给项目点个 ⭐ Star
- 分享给其他开发者
- 提交 Issue 或 Pull Request 来帮助改进项目 
