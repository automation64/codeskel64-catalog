# Snippet: 2.0.0
# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_select_packages() {
  bl64_dbg_app_show_function
  local packages=''
  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    packages='X_OS_PACKAGE_LIST_X'
    [[ "$INST64_X_APP_NAME_CAPS_X_DEVELOPMENT" == "$BL64_VAR_ON" ]] &&
      packages="${packages} X_OS_PACKAGE_LIST_X"
  fi
  [[ -n "$packages" ]] && echo "$packages"
}

function inst64_X_APP_NAME_X_add_repository() {
  bl64_dbg_app_show_function
  local repository_url=''
  local repository_key=''
  local repository_extra_1=''
  local repository_extra_2=''

  # delete-me # Remove unused 'if' branches
  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    repository_url="${INST64_X_APP_NAME_CAPS_X_SOURCE_X_REPO_TYPE_CAPS_X}/${INST64_X_APP_NAME_CAPS_X_PLATFORM_X_REPO_TYPE_CAPS_X}"
    repository_key="$INST64_X_APP_NAME_CAPS_X_REPOSITORY_KEY_X_REPO_TYPE_CAPS_X"
  elif bl64_os_match "${X_BL64_OS_ID_X}"; then
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
  local packages=''

  inst64_X_APP_NAME_X_add_repository ||
    return $?

  bl64_msg_show_task 'deploy packages'
  packages="$(inst64_X_APP_NAME_X_select_packages)" ||
    return $?
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages
}

# X_CODE_PLACEHOLDER_2_X
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-EXTERNAL}"
export INST64_X_APP_NAME_CAPS_X_PLATFORM_X_REPO_TYPE_CAPS_X="${INST64_X_APP_NAME_CAPS_X_PLATFORM_X_REPO_TYPE_CAPS_X:-X_REPO_PLATFORM_X}"

export INST64_X_APP_NAME_CAPS_X_REPOSITORY_NAME='X_REPO_NAME_X'
export INST64_X_APP_NAME_CAPS_X_SOURCE_X_REPO_TYPE_CAPS_X='X_REPO_URL_X'
export INST64_X_APP_NAME_CAPS_X_REPOSITORY_KEY_X_REPO_TYPE_CAPS_X='X_KEY_URL_X'

# X_CODE_PLACEHOLDER_3_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'EXTERNAL' ]]; then
    inst64_X_APP_NAME_X_install_external_packages
  fi

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'EXTERNAL' &&
    bl64_check_privilege_root &&
    bl64_pkg_setup
