# functions used on an ssh remote host

_set_git_user_to_ssh_lc_vars() {
    # set git user if unset to env vars provided via ssh

    # set commit user name if unset
    if ! git config user.name > /dev/null && [[ -n $LC_GIT_USER_NAME ]]; then
        # set to $USER title cased, with . replaced by a space
        git config --global user.name "$LC_GIT_USER_NAME"
        echo "Set git user.name: $LC_GIT_USER_NAME"
    fi

    # set commit user email if unset
    if ! git config user.email > /dev/null && [[ -n $LC_GIT_USER_EMAIL ]]; then
        git config --global user.email "$LC_GIT_USER_EMAIL"
        echo "Set git user.email: $LC_GIT_USER_EMAIL"
    fi
}
