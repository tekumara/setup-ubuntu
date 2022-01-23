# just the minimal set I actually use
# see also:
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/kubectl/kubectl.plugin.zsh
# https://github.com/ahmetb/kubectl-aliases
alias k='kubectl'
alias kge='kubectl get events --sort-by='{.lastTimestamp}''
keb() {
    kubectl exec -i -t "$1" -- /bin/bash
}
kes() {
    kubectl exec -i -t "$1" -- /bin/sh
}
