READLINK=$(which greadlink || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Start with standart oh-my-zsh setup
. $DOTFILES_DIR/.oh_my_zsh

# Make utilities available
PATH="$DOTFILES_DIR/bin:$PATH"

# Add custom configurations
for DOTFILE in $DOTFILES_DIR/system/.{function,path,env,alias,completion,custom}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

# Add OS depending configurations
if is-macos; then
  OS_DOTFILES_DIR=$DOTFILES_DIR/system/macos
else
  OS_DOTFILES_DIR=$DOTFILES_DIR/system/linux
fi

for DOTFILE in $OS_DOTFILES_DIR/.{env,alias,function}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

unset DOTFILE
