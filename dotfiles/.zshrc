# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    yous/vanilli.sh
    chrissicool/zsh-256color

    # pure is a fancy prompt and depends on zsh-async
    mafredri/zsh-async
    sindresorhus/pure

    zdharma/fast-syntax-highlighting
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-autosuggestions

    agkozak/zsh-z
EOF
fi

source ~/.zsh_plugins.sh

#source "$HOME/.zshrc.d/init.plugin.zsh"
#source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
#source "$HOME/.zshrc.d/node.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"

# increase history size
HISTSIZE=50000
SAVEHIST=50000

# fzf keybindings (CTRL-T, CTRL-R) must be loaded after the prezto editor module
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"
