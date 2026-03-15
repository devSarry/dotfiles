# 🚀 Quick Start Guide

**Complete beginner to dotfiles?** This guide will get you from zero to a fully configured development environment in under 15 minutes.

## 📖 What are dotfiles?

Dotfiles are configuration files for your development tools (terminal, editor, git, etc.). This repository automates the installation and configuration of 50+ development tools using Ansible, so you get a consistent setup across different machines.

## ⏱️ Time Estimate: 8-15 minutes

- **Prerequisites**: 2-3 minutes
- **Installation**: 5-12 minutes (varies by system and internet speed)
- **Basic Configuration**: 1-3 minutes

## 📋 Step 1: Prerequisites Check (2-3 minutes)

Before running anything, let's make sure your system is ready:

### Check Your Operating System

This works on:
- ✅ **macOS** (Monterey 12.0+)
- ✅ **Ubuntu** (20.04+)
- ✅ **Fedora** (any recent version)
- ✅ **Arch Linux** (any recent version)

```bash
# Check your OS version
uname -a
```

### Install Package Manager (macOS Only)

**macOS users need to install Homebrew first:**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

> 📖 **What is Homebrew?** It's the missing package manager for macOS. [Learn more](https://brew.sh/)

### Update Your System

**IMPORTANT**: Update your system packages first:

```bash
# macOS
brew update && brew upgrade

# Ubuntu
sudo apt update && sudo apt upgrade -y

# Fedora
sudo dnf update && sudo dnf upgrade -y

# Arch Linux
sudo pacman -Syu
```

> ⏰ **This may take 5-10 minutes depending on your system**

### Internet Connection

Make sure you have a stable internet connection - we'll be downloading lots of tools!

## 🚀 Step 2: Run the Bootstrap (5-10 minutes)

Now for the magic! One command installs everything:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/devSarry/dotfiles/main/bin/dotfiles)"
```

### What You'll See

The script will show progress like this:

```
 [✓] Loading Setup for detected OS: darwin
 [✓] Installing Homebrew (This may take 5-10 minutes)
 [✓] Installing Git
 [✓] Installing Ansible
 [✓] Installing 1Password CLI
 [✓] Downloading dotfiles repository (This may take a minute)
 [✓] Installing Ansible dependencies (This may take a few minutes)
```

> **Note**: On macOS, 1Password CLI is automatically installed but you don't need to configure it immediately - you can run dotfiles without 1Password setup.

### If Something Goes Wrong

- **Script stops with an error?** → See our [Troubleshooting Guide](TROUBLESHOOTING.md)
- **Need help?** → Join our [Discord](https://discord.gg/5M4hjfyRBj) or [create an issue](https://github.com/TechDufus/dotfiles/issues)

## ⚙️ Step 3: Basic Configuration (2-3 minutes)

After installation, you'll have a default configuration. Let's personalize it:

### Edit Your Configuration

```bash
# Open your config file
cd ~/.dotfiles
nvim group_vars/all.yml  # or vim if you prefer
```

### Essential Settings

At minimum, update these settings in your `all.yml`:

```yaml
# Required: Your name for git commits
git_user_name: "Your Name"

# Choose which tools to install (true = install, false = skip)
default_roles:
  - role: core           # Essential system tools
  - role: zsh           # Modern shell
  - role: git           # Version control
  - role: neovim        # Text editor
  # ... see file for all options
```

### Apply Your Changes

```bash
# Run dotfiles again to apply your customization
dotfiles
```

## 🎉 You're Done!

Your development environment is now set up! Here's what you got:

- **Modern shell** (zsh with oh-my-zsh)
- **Text editor** (Neovim with configuration)
- **Developer tools** (git, tmux, fzf, and more)
- **Package managers** for different languages
- **Automatic updates** with the `dotfiles` command

## 🔄 What's Next?

### Daily Usage

```bash
# Update your environment anytime
dotfiles

# Install specific tools only
dotfiles -t neovim,git

# See what would change (dry run)
dotfiles --check
```

### Advanced Configuration

- **Secure secrets**: Set up [1Password integration](../README.md#1password-integration)
- **More examples**: Check out [configuration examples](EXAMPLES.md)
- **Customize roles**: Edit individual tool configs in the `roles/` directory

### Get Help

- 💬 **Discord**: [Join our community](https://discord.gg/5M4hjfyRBj)
- 🐛 **Issues**: [Report problems](https://github.com/TechDufus/dotfiles/issues)
- 📖 **Docs**: [Full documentation](../README.md)

---

**Questions about this guide?** Please [open an issue](https://github.com/TechDufus/dotfiles/issues) - we'd love to improve it!