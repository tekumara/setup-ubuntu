# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# activate virtualenv in .venv/ or venv/
alias venv='{[[ -d .venv ]] && . .venv/bin/activate} || {[[ -d venv ]] && . venv/bin/activate} || echo "Missing .venv/"'
# create venv
alias mkvenv='virtualenv .venv'

# load virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=${PIPX_HOME:-$HOME/.local/pipx}/venvs/virtualenvwrapper/bin/python
source virtualenvwrapper.sh
