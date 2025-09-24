#!/bin/bash
set -eufo pipefail

# Configurar Ghostty con el tema Catppuccin (más popular en 2024-2025)
ghosttyConfigFile="$HOME/.config/ghostty/config"
ghosttyThemesDir="$HOME/.config/ghostty/themes"

echo "🎨  Configurando tema Catppuccin para Ghostty"

# Asegurar que el directorio de configuración existe
if [ ! -d "$(dirname "$ghosttyConfigFile")" ]; then
  mkdir -p "$(dirname "$ghosttyConfigFile")"
  echo "✅  Creado directorio de configuración de Ghostty"
fi

# Crear directorio de temas si no existe
if [ ! -d "$ghosttyThemesDir" ]; then
  mkdir -p "$ghosttyThemesDir"
  echo "✅  Creado directorio de temas de Ghostty"
fi

# Descargar temas Catppuccin si no existen
if [ ! -f "$ghosttyThemesDir/catppuccin-mocha" ]; then
  echo "📥  Descargando tema catppuccin-mocha..."
  curl -s -o "$ghosttyThemesDir/catppuccin-mocha" https://raw.githubusercontent.com/catppuccin/ghostty/main/themes/catppuccin-mocha.conf
  echo "✅  Tema catppuccin-mocha descargado"
fi

if [ ! -f "$ghosttyThemesDir/catppuccin-latte" ]; then
  echo "📥  Descargando tema catppuccin-latte..."
  curl -s -o "$ghosttyThemesDir/catppuccin-latte" https://raw.githubusercontent.com/catppuccin/ghostty/main/themes/catppuccin-latte.conf
  echo "✅  Tema catppuccin-latte descargado"
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
