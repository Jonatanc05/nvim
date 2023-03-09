# Instalação

### Linux

- Execute:
```
cd ~/.config/
git clone https://github.com/Jonatanc05/nvim.git
```
- Execute `:PackerInstall` no Neovim

### Windows

- [Instale o MSYS2](https://www.msys2.org/)
- Abra um terminal msys2 e execute os seguintes comandos:
```
pacman -S mingw-w64-x86_64-clang --noconfirm ; pacman -S mingw-w64-x86_64-clang-tools-extra --noconfirm
```
- Adicione `{instalacao-msys2}/bin` ao path (por padrão basta um `setx path "%path%;C:\msys64\mingw64\bin"`)
- Clone esse repositório em `~/AppData/Local/nvim/`
- Abra o Neovim, ignore o erro e execute `:PackerInstall`
- Feche e abra o Neovim novamente e aguarde toda a instalação automática
