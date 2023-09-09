# X_CODE_PLACEHOLDER_1_X

# X_CODE_PLACEHOLDER_2_X
# Enable development packages?
export CNT64_X_APP_NAME_CAPS_X_FLAG_DEVELOPMENT="${CNT64_X_APP_NAME_CAPS_X_FLAG_DEVELOPMENT:-$BL64_VAR_OFF}"
# Use OS native package?
export CNT64_X_APP_NAME_CAPS_X_FLAG_NATIVE="${CNT64_X_APP_NAME_CAPS_X_FLAG_NATIVE:-$BL64_VAR_ON}"

# X_CODE_PLACEHOLDER_3_X
  local packages=''

  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    packages='X_OS_PACKAGE_LIST_X'
    [[ "$CNT64_X_APP_NAME_CAPS_X_FLAG_DEVELOPMENT" == "$BL64_VAR_ON" ]] &&
      packages="${packages} X_OS_PACKAGE_LIST_X"
  fi

  bl64_msg_show_task 'deploy packages'
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages ||
    return $?

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_cleanup_full
  return 0

# X_CODE_PLACEHOLDER_4_X
  [[ "$CNT64_X_APP_NAME_CAPS_X_FLAG_NATIVE" != "$BL64_VAR_ON" ]] &&
    bl64_msg_show_error 'installer supports OS native packages only' &&
    return 1

  bl64_os_check_version "${X_BL64_OS_ID_X}" &&
    bl64_check_privilege_root &&
    bl64_pkg_setup
