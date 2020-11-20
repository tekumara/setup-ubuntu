# prevent pip from installing globally
export PIP_REQUIRE_VIRTUALENV=true

# activate virtualenv in ./venv/
alias venv='. venv/bin/activate'

# load virtualenvwrapper
VIRTUALENVWRAPPER_PYTHON=$HOME/.local/pipx/venvs/virtualenvwrapper/bin/python
source "$HOME/.local/bin/virtualenvwrapper.sh"
