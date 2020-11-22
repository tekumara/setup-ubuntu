# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    #yous/vanilli.sh

    # pure is a fancy prompt and depends on zsh-async
    mafredri/zsh-async
    sindresorhus/pure

    zdharma/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions

    agkozak/zsh-z
EOF
fi

# init must run first
source "$HOME/.zshrc.d/init.plugin.zsh"

source ~/.zsh_plugins.sh

# completion runs after plugins have been loaded and added their completions to fpath
source "$HOME/.zshrc.d/completion.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"

# increase history size
HISTSIZE=50000
SAVEHIST=50000

# add fzf to path, and load fzf completion & keybindings (CTRL-T, CTRL-R)
source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"
