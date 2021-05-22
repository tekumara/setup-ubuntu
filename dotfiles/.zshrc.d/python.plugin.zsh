# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv - if a venv is active pip won't be installed so check first
alias mkvenv='[[ -z "${VIRTUAL_ENV}" ]] && python3 -m venv --clear .venv || echo Deactivate active virtualenv first'

# load virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python
source "$HOME/.local/bin/virtualenvwrapper.sh"
