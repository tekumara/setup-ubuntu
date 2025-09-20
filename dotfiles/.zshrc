# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Generate new ~/.zsh_plugins.sh if it does not exist or ~/.zshrc is newer
if [[ ! -f ~/.zsh_plugins.sh ]] || [[ ~/.zshrc -nt ~/.zsh_plugins.sh ]]; then
  echo "antibody bundle"
  antibody bundle <<- EOF > ~/.zsh_plugins.sh
    romkatv/powerlevel10k

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
source "$HOME/.zshrc.d/docker.plugin.zsh"
source "$HOME/.zshrc.d/git.plugin.zsh"
source "$HOME/.zshrc.d/python.plugin.zsh"
source "$HOME/.zshrc.d/kubes.plugin.zsh"
source "$HOME/.zshrc.d/ssh.remote.zsh"

# add fzf to path, and load fzf completion & keybindings (CTRL-T, CTRL-R)
source ~/.fzf.zsh

# same order as git log
FORGIT_FZF_DEFAULT_OPTS="--reverse $FORGIT_FZF_DEFAULT_OPTS"

# load completion system
_load_compinit

_set_git_user_to_ssh_lc_vars

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
