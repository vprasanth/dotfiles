#!/usr/bin/env zsh
#
# Dotfiles installer
# Usage:
#   ./install.sh           # Interactive mode - select what to install
#   ./install.sh --check   # Check what's installed vs missing
#   ./install.sh --pick    # Pick individual formulas to install
#   ./install.sh --all     # Install everything without prompting
#

set -euo pipefail

# Ensure core utilities are available
EXTRA_PATH="/usr/bin:/bin:/usr/sbin:/sbin:/opt/homebrew/bin"
export PATH="$EXTRA_PATH:$PATH"
echo "Added to PATH: $EXTRA_PATH"

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
  eza
  git-delta
  lazygit
  jq
  gh
  tlrc
  htop
  tree
  glow
  mike-engel/jwt-cli/jwt-cli
)

# Homebrew casks (GUI apps)
CASKS=(
  ghostty
  font-agave-nerd-font
  karabiner-elements
  rectangle
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
  which "$1" &>/dev/null
}

is_formula_installed() {
  local formula="$1"
  local cmd="${formula##*/}"  # Extract command name (handles taps like mike-engel/jwt-cli/jwt-cli)

  # Check if binary exists on system (regardless of install method)
  which "$cmd" &>/dev/null || brew list --formula "$formula" &>/dev/null 2>&1
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
  echo -n "$prompt [y/N] "
  read -r response
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

pick_and_install() {
  local missing=()
  local formula cmd

  # Collect missing formulas
  for formula in "${FORMULAS[@]}"; do
    cmd="${formula##*/}"
    if ! which "$cmd" &>/dev/null && ! brew list --formula "$formula" &>/dev/null 2>&1; then
      missing+=("$formula")
    fi
  done

  if [[ ${#missing[@]} -eq 0 ]]; then
    success "All formulas already installed"
    return
  fi

  local to_install=()

  if which fzf &>/dev/null; then
    # Use fzf for multi-select
    info "Select formulas to install (TAB to select, ENTER to confirm):"
    local selected
    selected=$(printf '%s\n' "${missing[@]}" | fzf --multi --height=40% --reverse --border --header="TAB=select, ENTER=confirm, ESC=cancel")
    [[ -z "$selected" ]] && return
    to_install=(${(f)selected})
  else
    # Fallback to numbered menu
    echo ""
    info "Missing formulas:"
    for i in {1..${#missing[@]}}; do
      echo "  $i) ${missing[$i]}"
    done
    echo ""
    echo "Enter numbers to install (e.g., 1 3 4), 'a' for all, or 'q' to quit:"
    read -r selection

    [[ "$selection" == "q" ]] && return

    if [[ "$selection" == "a" ]]; then
      to_install=("${missing[@]}")
    else
      for num in ${=selection}; do
        if [[ "$num" =~ ^[0-9]+$ ]] && (( num >= 1 && num <= ${#missing[@]} )); then
          to_install+=("${missing[$num]}")
        fi
      done
    fi
  fi

  if [[ ${#to_install[@]} -eq 0 ]]; then
    warn "No valid selection"
    return
  fi

  echo ""
  info "Will install: ${to_install[*]}"
  if prompt_yes_no "Proceed?"; then
    brew install "${to_install[@]}"
    success "Done!"
  fi
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
    --pick|-p)
      pick_and_install
      ;;
    --help|-h)
      echo "Usage: $0 [OPTIONS]"
      echo ""
      echo "Options:"
      echo "  --check, -c    Show what's installed vs missing"
      echo "  --pick, -p     Pick individual formulas to install"
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
