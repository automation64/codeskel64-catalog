function cnt64_X_APP_NAME_X_select_packages() {
  local packages=''
  local version_legacy='X_LEGACY_VERSION_X'
  local version_target=''

  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    bl64_msg_show_alert "fixing package version_target for compatibility to target OS (${version_legacy})"
    version_target="==${version_legacy}.*"
  elif [[ "$CNT64_X_APP_NAME_CAPS_X_VERSION" == 'latest' ]]; then
    version_target=''
  else
    version_target="==${CNT64_X_APP_NAME_CAPS_X_VERSION}.*"
  fi
  packages="X_PYTHON_MODULE_X${version_target}"
  [[ -n "$packages" ]] && echo "$packages"
}

function cnt64_X_APP_NAME_X_install_with_pip() {
  local packages=''

  packages="$(cnt64_X_APP_NAME_X_select_packages)" ||
    return $?

  bl64_fs_set_umask "$BL64_FS_UMASK_RW_USER_RO_ALL" &&
    bl64_py_pip_usr_prepare &&
    bl64_py_pip_usr_deploy "$packages"
}

function cnt64_X_APP_NAME_X_install_with_pipx() {
  local packages=''

  packages="$(cnt64_X_APP_NAME_X_select_packages)" ||
    return $?

  pipx install "$packages"
}

# X_CODE_PLACEHOLDER_1_X

# X_CODE_PLACEHOLDER_2_X
export CNT64_X_APP_NAME_CAPS_X_VERSION="${CNT64_X_APP_NAME_CAPS_X_VERSION:-latest}"
# Use OS native package?
export CNT64_X_APP_NAME_CAPS_X_FLAG_NATIVE="${CNT64_X_APP_NAME_CAPS_X_FLAG_NATIVE:-$BL64_VAR_OFF}"
# Use Python PIPX?
export CNT64_X_APP_NAME_CAPS_X_PIPX="${CNT64_X_APP_NAME_CAPS_X_PIPX:-$BL64_VAR_OFF}"

# X_CODE_PLACEHOLDER_3_X
  bl64_msg_show_task 'deploy application'
  if [[ "$CNT64_X_APP_NAME_CAPS_X_PIPX" == "$BL64_VAR_ON" ]]; then
    cnt64_X_APP_NAME_X_install_with_pipx
  else
    cnt64_X_APP_NAME_X_install_with_pip
  fi

# X_CODE_PLACEHOLDER_4_X
  [[ "$CNT64_X_APP_NAME_CAPS_X_FLAG_NATIVE" != "$BL64_VAR_OFF" ]] &&
    bl64_msg_show_error 'installer supports Python modules only' &&
    return 1

  bl64_check_export 'CNT64_X_APP_NAME_CAPS_X_HOME' &&
    bl64_check_directory "$CNT64_X_APP_NAME_CAPS_X_HOME" &&
    bl64_os_check_version \
      "${BL64_OS_ALM}-8" \
      "${BL64_OS_CNT}-8" \
      "${BL64_OS_DEB}-10" "${BL64_OS_DEB}-11" \
      "${BL64_OS_FD}-33" "${BL64_OS_FD}-35" "${BL64_OS_FD}-36" \
      "${BL64_OS_OL}-8" "${BL64_OS_OL}-9" \
      "${BL64_OS_RCK}-8" "${BL64_OS_RCK}-9" \
      "${BL64_OS_RHEL}-8" \
      "${BL64_OS_UB}-20" "${BL64_OS_UB}-21" "${BL64_OS_UB}-22" &&
    bl64_py_setup
