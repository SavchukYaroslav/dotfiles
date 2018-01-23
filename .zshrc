# Start with standart oh-my-zsh setup
. `pwd`/.oh_my_zsh

# Add custom configurations
for DOTFILE in `pwd`/system/.{function,path,env,alias,completion,custom}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done
