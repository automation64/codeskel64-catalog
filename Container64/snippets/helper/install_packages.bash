# X_CODE_PLACEHOLDER_3_X

function cnt64_setup_select_packages() {
  bl64_dbg_app_show_function
  local packages=''
  if bl64_os_match "${X_TARGET_OS_X}"; then
    packages="${packages} X_PACKAGE_LIST_X"
  fi
  [[ -n "$packages" ]] && echo "$packages"
}

function cnt64_setup_install_packages() {
  bl64_dbg_app_show_function
  local packages=''
  bl64_msg_show_task 'deploy packages'
  packages="$(cnt64_setup_select_packages)" ||
    return $?
  # shellcheck disable=SC2086
  bl64_pkg_deploy $packages
}

# X_CODE_PLACEHOLDER_1_X
  cnt64_setup_install_packages

# X_CODE_PLACEHOLDER_2_X
  bl64_os_check_version \
    "X_TARGET_OS1_X" &&
  bl64_pkg_setup &&
