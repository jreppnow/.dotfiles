curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
fisher install IlanCosman/tide@v6
tide configure
fisher install tomyun/base16-fish
base16-papercolor-dark
fisher install danhper/fish-ssh-agent

fish_add_path --path $HOME/.cargo/bin $HOME/.bin
set -u -x CMAKE_EXPORT_COMPILE_COMMANDS TRUE

for fun in functions/*.fish
    ln -s $fun $HOME/.config/fish/functions/ 
end
