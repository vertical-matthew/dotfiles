
#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${1:-$HOME/.dotfiles}"
NVIM_TARGET="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

# detect OS + package manager
install_deps() {
  if command -v brew >/dev/null 2>&1; then
    brew install neovim git ripgrep fd node python
  elif command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update
    sudo apt-get install -y neovim git ripgrep fd-find nodejs npm python3 python3-pip
    # ubuntu names fd as fdfind
    mkdir -p "$HOME/.local/bin"
    ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd" || true
  elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y neovim git ripgrep fd-find nodejs npm python3 python3-pip
  elif command -v pacman >/dev/null 2>&1; then
    sudo pacman -Syu --noconfirm neovim git ripgrep fd nodejs npm python python-pip
  else
    echo "No supported package manager found (brew/apt/dnf/pacman). Install deps manually."
  fi
}

install_deps

python3 -m pip install --user -U pynvim || true
npm i -g pyright || true

mkdir -p "$(dirname "$NVIM_TARGET")"

# backup existing
if [ -e "$NVIM_TARGET" ] && [ ! -L "$NVIM_TARGET" ]; then
  mv "$NVIM_TARGET" "${NVIM_TARGET}.bak.$(date +%Y%m%d%H%M%S)"
fi

ln -sfn "$REPO_DIR/nvim" "$NVIM_TARGET"

# install plugins headless
nvim --headless "+Lazy! sync" +qa || nvim --headless "+Lazy sync" +qa

echo "Done. Run: nvim"
