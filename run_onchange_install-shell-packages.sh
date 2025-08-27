#!/bin/bash
set -eufo pipefail

# Configurar Ghostty con el tema Catppuccin (más popular en 2024-2025)
ghosttyConfigFile="$HOME/.config/ghostty/config"

echo "🎨  Configurando tema Catppuccin para Ghostty"

# Asegurar que el directorio de configuración existe
if [ ! -d "$(dirname "$ghosttyConfigFile")" ]; then
  mkdir -p "$(dirname "$ghosttyConfigFile")"
  echo "✅  Creado directorio de configuración de Ghostty"
fi

# Verificar si Ghostty ya tiene un tema configurado
if [ -f "$ghosttyConfigFile" ] && grep -q "^theme" "$ghosttyConfigFile"; then
  echo "ℹ️  Ghostty ya tiene un tema configurado, actualizando a Catppuccin..."
  # Actualizar la línea del tema existente
  sed -i '' 's/^theme.*/theme = dark:catppuccin-mocha,light:catppuccin-latte/' "$ghosttyConfigFile"
else
  echo "🔧  Configurando tema Catppuccin para modo oscuro y claro..."
  # Agregar configuración del tema
  echo "theme = dark:catppuccin-mocha,light:catppuccin-latte" >> "$ghosttyConfigFile"
fi

echo "✅  Tema Catppuccin configurado (oscuro: mocha, claro: latte)"

# Instalar plugin zsh-autosuggestions si no existe
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
  echo "💬  Instalando plugin zsh-autosuggestions"
  
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  
  echo "✅  Plugin zsh-autosuggestions instalado"
fi

