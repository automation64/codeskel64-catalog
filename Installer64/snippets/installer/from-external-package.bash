# Snippet: 3.0.0
# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_add_repository() {
  bl64_dbg_app_show_function
  local repository_url=''
  local repository_key=''
  local repository_extra_1=''
  local repository_extra_2=''

  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    # delete-me # For YUM. Remove if not used
    repository_url="${INST64_X_APP_NAME_CAPS_X_SOURCE_X_REPO_TYPE_CAPS_X}/${INST64_X_APP_NAME_CAPS_X_PLATFORM_X_REPO_TYPE_CAPS_X}"
    repository_key="$INST64_X_APP_NAME_CAPS_X_REPOSITORY_KEY_X_REPO_TYPE_CAPS_X"
  elif bl64_os_match "${X_BL64_OS_ID_X}"; then
    # delete-me # For APT. Remove if not used
    repository_url="${INST64_X_APP_NAME_CAPS_X_SOURCE_X_REPO_TYPE_CAPS_X}"
    repository_key="$INST64_X_APP_NAME_CAPS_X_REPOSITORY_KEY_X_REPO_TYPE_CAPS_X"
    repository_extra_1='X_EXTRA1_X'
    repository_extra_2='X_EXTRA2_X'
  fi

  bl64_msg_show_task 'Add external package repository'
  bl64_pkg_repository_add "$INST64_X_APP_NAME_CAPS_X_REPOSITORY_NAME" \
    "$repository_url" "$repository_key" \
    "$repository_extra_1" "$repository_extra_2"
}

function inst64_X_APP_NAME_X_install_external_packages() {
  bl64_dbg_app_show_function
  bl64_msg_show_task 'deploy packages'
  # shellcheck disable=SC2086
  bl64_pkg_deploy $INST64_X_APP_NAME_CAPS_X_PACKAGES
}

# X_GLOBALS_PLACEHOLDER_X
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-EXTERNAL}"
export INST64_X_APP_NAME_CAPS_X_PLATFORM_X_REPO_TYPE_CAPS_X="${INST64_X_APP_NAME_CAPS_X_PLATFORM_X_REPO_TYPE_CAPS_X:-X_REPO_PLATFORM_X}"

export INST64_X_APP_NAME_CAPS_X_REPOSITORY_NAME='X_REPO_NAME_X'
export INST64_X_APP_NAME_CAPS_X_SOURCE_X_REPO_TYPE_CAPS_X='X_REPO_URL_X'
export INST64_X_APP_NAME_CAPS_X_REPOSITORY_KEY_X_REPO_TYPE_CAPS_X='X_KEY_URL_X'

# X_INSTALL_PLACEHOLDER_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'EXTERNAL' ]]; then
    inst64_X_APP_NAME_X_install_external_packages
  fi

# X_INIT_PLACEHOLDER_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'EXTERNAL' &&
    bl64_check_privilege_root &&
    bl64_pkg_setup

# X_PREPARE_PLACEHOLDER_X
  inst64_X_APP_NAME_X_add_repository

# X_VERIFY_PLACEHOLDER_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'EXTERNAL' ]]; then
# example #    "/usr/bin/${INST64_X_APP_NAME_CAPS_X_CLI_NAME}" --version
  fi

# X_SELECT_PKG_PLACEHOLDER_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'EXTERNAL' ]]; then
    if bl64_os_match "${X_BL64_OS_ID_X}"; then
      INST64_X_APP_NAME_CAPS_X_PACKAGES='X_OS_PACKAGE_LIST_X'
      [[ "$INST64_X_APP_NAME_CAPS_X_DEVELOPMENT" == "$BL64_VAR_ON" ]] &&
        INST64_X_APP_NAME_CAPS_X_PACKAGES="${INST64_X_APP_NAME_CAPS_X_PACKAGES} X_OS_PACKAGE_LIST_X"
    fi
  fi
