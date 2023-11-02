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

function inst64_X_APP_NAME_X_install_os_packages() {
  bl64_dbg_app_show_function
  local packages=''

  bl64_msg_show_task 'deploy packages'
  packages="$(inst64_X_APP_NAME_X_select_packages)" ||
    return $?
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages
}

# X_CODE_PLACEHOLDER_2_X
# Enable development packages?
export INST64_X_APP_NAME_CAPS_X_DEVELOPMENT="${INST64_X_APP_NAME_CAPS_X_DEVELOPMENT:-$BL64_VAR_OFF}"
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-NATIVE}"

# X_CODE_PLACEHOLDER_3_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'NATIVE' ]]; then
    inst64_X_APP_NAME_X_install_os_packages
  fi

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_check_privilege_root &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'NATIVE' &&
    bl64_pkg_setup
