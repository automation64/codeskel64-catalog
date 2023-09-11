function inst64_X_APP_NAME_X_select_packages() {
  local packages=''
  local version_legacy='X_LEGACY_VERSION_X'
  local version_target=''

  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    bl64_msg_show_alert "fixing package version_target for compatibility to target OS (${version_legacy})"
    version_target="==${version_legacy}.*"
  elif [[ "$INST64_X_APP_NAME_CAPS_X_VERSION" == 'latest' ]]; then
    version_target=''
  else
    version_target="==${INST64_X_APP_NAME_CAPS_X_VERSION}.*"
  fi
  packages="X_PYTHON_MODULE_X${version_target}"
  [[ -n "$packages" ]] && echo "$packages"
}

function inst64_X_APP_NAME_X_install_with_pip() {
  local packages=''

  packages="$(inst64_X_APP_NAME_X_select_packages)" ||
    return $?

  bl64_fs_set_umask "$BL64_FS_UMASK_RW_USER_RO_ALL" &&
    bl64_py_pip_usr_prepare &&
    bl64_py_pip_usr_deploy "$packages"
}

function inst64_X_APP_NAME_X_install_with_pipx() {
  local packages=''

  packages="$(inst64_X_APP_NAME_X_select_packages)" ||
    return $?

  pipx install "$packages"
}

# X_CODE_PLACEHOLDER_2_X
export INST64_X_APP_NAME_CAPS_X_VERSION="${INST64_X_APP_NAME_CAPS_X_VERSION:-latest}"
# Use OS native package?
export INST64_X_APP_NAME_CAPS_X_FLAG_NATIVE="${INST64_X_APP_NAME_CAPS_X_FLAG_NATIVE:-$BL64_VAR_OFF}"
# Use Python PIPX?
export INST64_X_APP_NAME_CAPS_X_PIPX="${INST64_X_APP_NAME_CAPS_X_PIPX:-$BL64_VAR_OFF}"

# X_CODE_PLACEHOLDER_3_X
  bl64_msg_show_task 'deploy application'
  if [[ "$INST64_X_APP_NAME_CAPS_X_PIPX" == "$BL64_VAR_ON" ]]; then
    inst64_X_APP_NAME_X_install_with_pipx
  else
    inst64_X_APP_NAME_X_install_with_pip
  fi

# X_CODE_PLACEHOLDER_4_X
  [[ "$INST64_X_APP_NAME_CAPS_X_FLAG_NATIVE" != "$BL64_VAR_OFF" ]] &&
    bl64_msg_show_error 'installer supports Python modules only' &&
    return 1

  bl64_os_check_version \
    "${BL64_OS_UB}-20" "${BL64_OS_UB}-21" "${BL64_OS_UB}-22" &&
    bl64_py_setup
