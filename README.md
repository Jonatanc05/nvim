# Instalação

## Linux

- Mova o conteúdo deste repositório para ~/.config/nvim/
- Execute `sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim`
- Execute `PlugInstall` no Neovim

## Windows

- Mova o conteúdo deste repositório para ~/AppData/Local/nvim/
- Execute `iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force` no PowerShell
- Execute `PlugInstall` no Neovim
