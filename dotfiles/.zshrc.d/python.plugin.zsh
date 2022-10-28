# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv and activate
alias mkvenv='virtualenv --clear .venv && . .venv/bin/activate'

# vscode debugger
debugpy() {
    local port=62888
    if [[ -z $VIRTUAL_ENV ]]; then
        echo Could not find an activated virtualenv
    else
        [[ -d $VIRTUAL_ENV/lib/python*/site-packages/debugpy(#qN) ]] || (echo "Installing debugpy" && pip install debugpy)
        echo "Attach vscode debugger to port $port" >&2
        python -m debugpy --listen "$port" --wait-for-client "$@"
    fi
}

alias pyright=node_modules/.bin/pyright

# load virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python
source "$HOME/.local/bin/virtualenvwrapper.sh"
