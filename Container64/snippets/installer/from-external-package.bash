# X_CODE_PLACEHOLDER_1_X

# X_CODE_PLACEHOLDER_2_X

# X_CODE_PLACEHOLDER_3_X
  if bl64_os_match "${X_BL64_OS_ID_X}"; then
    cnt64_X_APP_NAME_X_install_X_TARGET_OS_X
  fi
  # shellcheck disable=SC2181
  (($? != 0)) && return 1

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_cleanup_full
  return 0

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version "${X_BL64_OS_ID_X}" &&
    bl64_check_privilege_root &&
    bl64_pkg_setup


# X_STAND_ALONE_FUNCTIONS_X #
function cnt64_X_APP_NAME_X_install_X_TARGET_OS_X() {
  local repository_name='X_REPO_NAME_X'
  local repository_platform='X_REPO_PLATFORM_X'
  local repository_url='X_REPO_URL_X'
# example #  local repository_url="X_REPO_URL_X/${repository_platform}"
  local repository_key='X_REPO_KEY_X'
  local packages='X_OS_PACKAGE_LIST_X'

  bl64_msg_show_task 'Add YUM package repository'
  bl64_pkg_repository_add "$repository_name" "$repository_url" "$repository_key" ||
    return $?

  bl64_msg_show_task 'deploy packages'
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages
}
