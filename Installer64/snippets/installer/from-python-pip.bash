# Snippet: 3.0.0
# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_install_with_pip() {
  bl64_dbg_app_show_function
  bl64_fs_set_umask "$BL64_FS_UMASK_RW_USER_RO_ALL" &&
    bl64_py_pip_usr_prepare &&
    bl64_py_pip_usr_deploy "$INST64_X_APP_NAME_CAPS_X_PACKAGES"
}

function inst64_X_APP_NAME_X_install_with_pipx() {
  bl64_dbg_app_show_function
  pipx install "$INST64_X_APP_NAME_CAPS_X_PACKAGES"
}

# X_CODE_PLACEHOLDER_2_X
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-PIP}"
export INST64_X_APP_NAME_CAPS_X_VERSION="${INST64_X_APP_NAME_CAPS_X_VERSION:-latest}"
export INST64_X_APP_NAME_CAPS_X_PIPX_BIN='/usr/bin/pipx'

# X_CODE_PLACEHOLDER_3_X
  bl64_msg_show_task 'deploy application'
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'PIPX' ]]; then
    inst64_X_APP_NAME_X_install_with_pipx
  elif [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'PIP' ]]; then
    inst64_X_APP_NAME_X_install_with_pip
  fi

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "$X_BL64_OS_ID_X" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'PIP' 'PIPX' &&
    bl64_check_privilege_not_root &&
    bl64_check_command "$INST64_X_APP_NAME_CAPS_X_PIPX_BIN"

# X_CODE_PLACEHOLDER_6_X
  bl64_py_setup

# X_CODE_PLACEHOLDER_8_X
  local version_legacy='X_LEGACY_VERSION_X'
  local version_target=''

  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'PIPX' || "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'PIP' ]]; then
    if bl64_os_match "${X_BL64_OS_ID_X}"; then
      bl64_msg_show_alert "fixing package version_target for compatibility to target OS (${version_legacy})"
      version_target="==${version_legacy}.*"
    elif [[ "$INST64_X_APP_NAME_CAPS_X_VERSION" == 'latest' ]]; then
      version_target=''
    else
      version_target="==${INST64_X_APP_NAME_CAPS_X_VERSION}.*"
    fi
    INST64_X_APP_NAME_CAPS_X_PACKAGES="X_PYTHON_MODULE_X${version_target}"
  fi
