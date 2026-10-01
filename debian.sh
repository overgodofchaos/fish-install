set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if ! command -v sudo >/dev/null 2>&1; then
    if [ "$(id -u)" -eq 0 ]; then
        apt update
        apt install -y sudo
    else
        echo "Need root or sudo" >&2
        exit 1
    fi
fi

sudo apt update
sudo apt install -y fish

mkdir -p ~/.config/fish
cp "$SCRIPT_DIR/config.fish" ~/.config/fish/config.fish
sudo chsh -s "$(command -v fish)" "$USER"

echo "Success"