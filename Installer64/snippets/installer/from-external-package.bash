# Snippet: 2.0.0
# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_install_X_TARGET_OS_X() {
  local repository_name='X_REPO_NAME_X'
  local repository_platform='X_REPO_PLATFORM_X'
  local repository_url=''
  local repository_key='X_REPO_KEY_X'
  local packages='X_OS_PACKAGE_LIST_X'

  bl64_msg_show_task 'Add YUM package repository'
  repository_url="${INST64_X_APP_NAME_CAPS_X_SOURCE}/${repository_platform}"
  bl64_pkg_repository_add "$repository_name" "$repository_url" "$repository_key" ||
    return $?

  bl64_msg_show_task 'deploy packages'
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages
}

function inst64_X_APP_NAME_X_install_external_packages() {
  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    inst64_X_APP_NAME_X_install_X_TARGET_OS_X
  fi
}

# X_CODE_PLACEHOLDER_2_X
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-NATIVE}"

export INST64_X_APP_NAME_CAPS_X_SOURCE='X_REPO_URL_X'

# X_CODE_PLACEHOLDER_3_X
  inst64_X_APP_NAME_X_install_external_packages

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'NATIVE' &&
    bl64_check_privilege_root &&
    bl64_pkg_setup
