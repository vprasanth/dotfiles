#!/bin/bash
#
# Dotfiles installer
# Usage:
#   ./install.sh           # Interactive mode - select what to install
#   ./install.sh --check   # Check what's installed vs missing
#   ./install.sh --all     # Install everything without prompting
#

set -euo pipefail

# ============================================================================
# Configuration - Add new packages here
# ============================================================================

# Homebrew formulas (CLI tools)
FORMULAS=(
  stow
  neovim
  tmux
  ripgrep
  fd
  fzf
  bat
  zoxide
  fnm
)

# Homebrew casks (GUI apps)
CASKS=(
  ghostty
  font-agave-nerd-font
  karabiner-elements
)

# Stow packages to link (subdirectories of ./stow)
STOW_PACKAGES=(
  nvim
  tmux
  zsh
  git
  karabiner
)

# ============================================================================
# Helper functions
# ============================================================================

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

info()    { echo -e "${BLUE}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $1"; }
error()   { echo -e "${RED}[ERROR]${NC} $1"; }

is_installed() {
  command -v "$1" &>/dev/null
}

is_formula_installed() {
  brew list --formula "$1" &>/dev/null 2>&1
}

is_cask_installed() {
  brew list --cask "$1" &>/dev/null 2>&1
}

is_stowed() {
  local package="$1"
  local target="$HOME"

  # Check if the main config file/dir is a symlink pointing to our stow dir
  case "$package" in
    nvim)      [[ -L "$target/.config/nvim" ]] ;;
    tmux)      [[ -L "$target/.config/tmux" ]] ;;
    zsh)       [[ -L "$target/.zshrc" ]] ;;
    git)       [[ -L "$target/.gitconfig" ]] ;;
    karabiner) [[ -L "$target/.config/karabiner" ]] ;;
    btop)      [[ -L "$target/.config/btop" ]] ;;
    *)         return 1 ;;
  esac
}

# ============================================================================
# Core functions
# ============================================================================

check_homebrew() {
  if ! is_installed brew; then
    error "Homebrew not found. Install it first:"
    echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
  fi
}

show_status() {
  echo ""
  info "=== Homebrew Formulas ==="
  for formula in "${FORMULAS[@]}"; do
    if is_formula_installed "$formula"; then
      success "$formula"
    else
      warn "$formula (not installed)"
    fi
  done

  echo ""
  info "=== Homebrew Casks ==="
  for cask in "${CASKS[@]}"; do
    if is_cask_installed "$cask"; then
      success "$cask"
    else
      warn "$cask (not installed)"
    fi
  done

  echo ""
  info "=== Stow Packages ==="
  for package in "${STOW_PACKAGES[@]}"; do
    if is_stowed "$package"; then
      success "$package (linked)"
    else
      warn "$package (not linked)"
    fi
  done
  echo ""
}

install_formulas() {
  local to_install=()

  for formula in "${FORMULAS[@]}"; do
    if ! is_formula_installed "$formula"; then
      to_install+=("$formula")
    fi
  done

  if [[ ${#to_install[@]} -eq 0 ]]; then
    success "All formulas already installed"
    return
  fi

  info "Installing formulas: ${to_install[*]}"
  brew install "${to_install[@]}"
}

install_casks() {
  local to_install=()

  for cask in "${CASKS[@]}"; do
    if ! is_cask_installed "$cask"; then
      to_install+=("$cask")
    fi
  done

  if [[ ${#to_install[@]} -eq 0 ]]; then
    success "All casks already installed"
    return
  fi

  info "Installing casks: ${to_install[*]}"
  brew install --cask "${to_install[@]}"
}

link_stow_packages() {
  local stow_dir
  stow_dir="$(cd "$(dirname "$0")/stow" && pwd)"

  for package in "${STOW_PACKAGES[@]}"; do
    if [[ ! -d "$stow_dir/$package" ]]; then
      warn "Stow package '$package' not found, skipping"
      continue
    fi

    if is_stowed "$package"; then
      success "$package already linked"
    else
      info "Linking $package..."
      stow -d "$stow_dir" -t "$HOME" "$package"
      success "$package linked"
    fi
  done
}

# ============================================================================
# Interactive menu
# ============================================================================

prompt_yes_no() {
  local prompt="$1"
  local response
  read -rp "$prompt [y/N] " response
  [[ "$response" =~ ^[Yy]$ ]]
}

interactive_install() {
  echo ""
  echo "Dotfiles Installer"
  echo "=================="
  echo ""

  if prompt_yes_no "Install Homebrew formulas (CLI tools)?"; then
    install_formulas
  fi

  echo ""
  if prompt_yes_no "Install Homebrew casks (GUI apps)?"; then
    install_casks
  fi

  echo ""
  if prompt_yes_no "Link stow packages (config files)?"; then
    link_stow_packages
  fi

  echo ""
  success "Done!"
}

install_all() {
  info "Installing all packages..."
  install_formulas
  install_casks
  link_stow_packages
  success "Done!"
}

# ============================================================================
# Main
# ============================================================================

main() {
  check_homebrew

  case "${1:-}" in
    --check|-c)
      show_status
      ;;
    --all|-a)
      install_all
      ;;
    --help|-h)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --check, -c    Show what's installed vs missing"
      echo "  --all, -a      Install everything without prompting"
      echo "  --help, -h     Show this help"
      echo ""
      echo "Without options, runs in interactive mode."
      ;;
    *)
      interactive_install
      ;;
  esac
}

main "$@"
