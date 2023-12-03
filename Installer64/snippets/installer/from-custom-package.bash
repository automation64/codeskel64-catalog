# Snippet: 3.1.0
# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_install_custom_package() {
  bl64_dbg_app_show_function
  local work_path=''
  local app_target_mode='0755'
  local app_target_owner='root'
  local app_cli_source="${INST64_X_APP_NAME_CAPS_X_CLI_NAME}"

  bl64_msg_show_task 'download application'
  work_path="$(bl64_fs_create_tmpdir)" || return $?
  bl64_rxtx_web_get_file "${INST64_X_APP_NAME_CAPS_X_PACKAGE_URL}/${package_name}" "${work_path}/${package_name}" &&
# example #    bl64_arc_open_tar "${work_path}/${package_name}" "${work_path}" ||
# example #    bl64_arc_open_zip "${work_path}/${package_name}" "${work_path}" ||
    return $?

  bl64_msg_show_task 'deploy application'
  bl64_fs_create_dir "$app_target_mode" "$app_target_owner" "$app_target_owner" "$INST64_X_APP_NAME_CAPS_X_TARGET" &&
    # delete-me # Modify the following line to match the custom installer path
    "${$INST64_X_APP_NAME_CAPS_X_TARGET}/${INST64_X_APP_NAME_CAPS_X_INSTALLER}" ||
    return $?

  bl64_msg_show_task "publish application to searchable path (${INST64_LOCAL_BIN})"
  # shellcheck disable=SC2086
  bl64_fs_create_symlink \
      "${INST64_X_APP_NAME_CAPS_X_TARGET}/${app_cli_source}" "${INST64_LOCAL_BIN}/${INST64_X_APP_NAME_CAPS_X_CLI_NAME}" "$BL64_VAR_ON" ||
    return $?

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_rm_tmpdir "$work_path"
  return 0
}

# X_GLOBALS_PLACEHOLDER_X
export INST64_X_APP_NAME_CAPS_X_PLATFORM="${INST64_X_APP_NAME_CAPS_X_PLATFORM:-X_APP_PLATFORM_X}"
export INST64_X_APP_NAME_CAPS_X_SOURCE="${INST64_X_APP_NAME_CAPS_X_SOURCE:-X_APP_REPO_X}"
export INST64_X_APP_NAME_CAPS_X_TARGET="${INST64_X_APP_NAME_CAPS_X_TARGET:-${INST64_OPT_ROOT}/X_APP_NAME_X}"
export INST64_X_APP_NAME_CAPS_X_VERSION="${INST64_X_APP_NAME_CAPS_X_VERSION:-X_APP_VERSION_X}"
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-CUSTOM}"

export INST64_X_APP_NAME_CAPS_X_PACKAGE_URL=''
export INST64_X_APP_NAME_CAPS_X_INSTALLER=''

# X_INSTALL_PLACEHOLDER_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'CUSTOM' ]]; then
    inst64_X_APP_NAME_X_install_custom_package
  fi

# X_INIT_PLACEHOLDER_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'CUSTOM' &&
    bl64_check_privilege_root

# X_PREPARE_PLACEHOLDER_X
  bl64_arc_setup

# X_VERIFY_PLACEHOLDER_X
# example # "${INST64_LOCAL_BIN}/${INST64_X_APP_NAME_CAPS_X_CLI_NAME}" --help > /dev/null

# X_SELECT_PKG_PLACEHOLDER_X
  local package_prefix=''
  local package_sufix=''
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'CUSTOM' ]]; then
    package_prefix='X_PACKAGE_PREFIX_X'
    package_sufix='X_PACKAGE_SUFIX_X'
    # delete-me # Modify the following line to properly form the package name
    INST64_X_APP_NAME_CAPS_X_PACKAGES="${package_prefix}${INST64_X_APP_NAME_CAPS_X_VERSION}${INST64_X_APP_NAME_CAPS_X_PLATFORM}${package_sufix}"
    # delete-me # Modify the following line to properly form the package url
    INST64_X_APP_NAME_CAPS_X_PACKAGE_URL="${INST64_X_APP_NAME_CAPS_X_SOURCE}/v${INST64_X_APP_NAME_CAPS_X_VERSION}"
  fi
