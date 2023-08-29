# X_CODE_PLACEHOLDER_1_X

# X_CODE_PLACEHOLDER_2_X

# X_CODE_PLACEHOLDER_3_X
  local packages=''

  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    packages='X_OS_PACKAGE_LIST_X'
  fi

  bl64_msg_show_task 'deploy packages'
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages ||
    return $?

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_cleanup_full
  return 0

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version "${X_BL64_OS_ID_X}" &&
    bl64_check_privilege_root &&
    bl64_pkg_setup
