# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    # pure is a fancy prompt and depends on zsh-async
    mafredri/zsh-async
    sindresorhus/pure

    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-autosuggestions

    # fixes syntax colouring in tmux/cloud9 by setting TERM=screen-256color
    chrissicool/zsh-256color

    agkozak/zsh-z
EOF
fi

# minimal.zsh must run before zdharma/fast-syntax-highlighting
source "$HOME/.zshrc.d/minimal.zsh"
source ~/.zsh_plugins.sh
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/kubes.plugin.zsh"
source "$HOME/.zshrc.d/docker.plugin.zsh"

# add fzf to path, and load fzf completion & keybindings (CTRL-T, CTRL-R)
source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"

# load completion system
_load_compinit
