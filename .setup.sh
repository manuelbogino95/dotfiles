#!/bin/bash
set -eufo pipefail

echo "🚀  Setting up @manuelbogino95 dotfiles."

if xcode-select -p &> /dev/null; then
  echo "✅  Xcode command line tools are already installed."
else
  echo "🔧  Installing Xcode command line tools..."
  xcode-select --install &> /dev/null
  
  while ! xcode-select -p &> /dev/null; do
    sleep 5
  done
  echo "✅  Xcode command line tools installed successfully."
fi

if which -s "brew"; then
  echo "✅  Homebrew is already installed."
else
  echo "🍺  Installing Homebrew"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "✅  Homebrew installed successfully."
fi

if [ -f ~/.oh-my-zsh/oh-my-zsh.sh ]; then
  echo "✅  oh-my-zsh is already installed."
else
  echo "💻  Installing oh-my-zsh"
  yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
  echo "✅  oh-my-zsh installed successfully."
fi

echo "⚪️  Installing Chezmoi"
brew install chezmoi

chezmoi init --apply manuelbogino95
echo "✅  Chezmoi initialized"