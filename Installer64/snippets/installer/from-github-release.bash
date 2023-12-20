# Snippet: 3.0.0

# X_GLOBALS_PLACEHOLDER_X
export INST64_X_APP_NAME_CAPS_X_PLATFORM="${INST64_X_APP_NAME_CAPS_X_PLATFORM:-X_APP_PLATFORM_X}"
export INST64_X_APP_NAME_CAPS_X_TARGET="${INST64_X_APP_NAME_CAPS_X_TARGET:-${INST64_OPT_ROOT}/X_APP_NAME_X}"
export INST64_X_APP_NAME_CAPS_X_VERSION="${INST64_X_APP_NAME_CAPS_X_VERSION:-latest}"
# Install system wide? Requires root privilege
export INST64_X_APP_NAME_CAPS_X_SYSTEM_WIDE="${INST64_X_APP_NAME_CAPS_X_SYSTEM_WIDE:-YES}"
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-BINARY}"

export INST64_X_APP_NAME_CAPS_X_REPO_NAME='X_REPO_NAME_X'
export INST64_X_APP_NAME_CAPS_X_REPO_OWNER='X_REPO_OWNER_X'

export INST64_X_APP_NAME_CAPS_X_CLI_PATH="${INST64_LOCAL_BIN}/${INST64_X_APP_NAME_CAPS_X_CLI_NAME}"

# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_install_binary_release() {
  bl64_dbg_app_show_function
  local work_path=''
  local app_target_mode='0755'
  local app_target_owner='root'
  local app_cli_mode='0755'
  local app_cli_source="${INST64_X_APP_NAME_CAPS_X_CLI_NAME}"

  bl64_msg_show_task 'download application'
  work_path="$(bl64_fs_create_tmpdir)" || return $?
  bl64_rxtx_github_get_asset \
    "$INST64_X_APP_NAME_CAPS_X_REPO_OWNER" "$INST64_X_APP_NAME_CAPS_X_REPO_NAME" "$INST64_X_APP_NAME_CAPS_X_VERSION" "$INST64_X_APP_NAME_CAPS_X_PACKAGES" "${work_path}/${INST64_X_APP_NAME_CAPS_X_PACKAGES}" &&
    bl64_arc_open_tar "${work_path}/${INST64_X_APP_NAME_CAPS_X_PACKAGES}" "${work_path}" ||
    return $?

  bl64_msg_show_task 'deploy application'
  bl64_lib_flag_is_enabled "$INST64_X_APP_NAME_CAPS_X_SYSTEM_WIDE" || app_target_owner="$BL64_VAR_DEFAULT"
  bl64_fs_create_dir "$app_target_mode" "$app_target_owner" "$app_target_owner" "$INST64_X_APP_NAME_CAPS_X_TARGET" &&
    bl64_fs_copy_files "$app_cli_mode" "$app_target_owner" "$app_target_owner" "$INST64_X_APP_NAME_CAPS_X_TARGET" "${work_path}/${app_cli_source}" ||
    return $?

  bl64_lib_flag_is_enabled "$INST64_X_APP_NAME_CAPS_X_SYSTEM_WIDE" || INST64_X_APP_NAME_CAPS_X_CLI_PATH="${INST64_X_APP_NAME_CAPS_X_TARGET}/${INST64_X_APP_NAME_CAPS_X_CLI_NAME}"
  bl64_msg_show_task "publish application to searchable path (${INST64_LOCAL_BIN})"
  # shellcheck disable=SC2086
  bl64_fs_create_symlink "${INST64_X_APP_NAME_CAPS_X_TARGET}/${app_cli_source}" "$INST64_X_APP_NAME_CAPS_X_CLI_PATH" "$BL64_VAR_ON" ||
    return $?

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_rm_tmpdir "$work_path"
  return 0
}

# X_INSTALL_PLACEHOLDER_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'BINARY' ]]; then
    inst64_X_APP_NAME_X_install_binary_release
  fi

# X_SELECT_PKG_PLACEHOLDER_X
  local package_prefix=''
  local package_sufix=''
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'BINARY' ]]; then
    if [[ "$INST64_X_APP_NAME_CAPS_X_VERSION" == 'latest' ]]; then
      INST64_X_APP_NAME_CAPS_X_VERSION="$(bl64_vcs_github_release_get_latest "$INST64_X_APP_NAME_CAPS_X_REPO_OWNER" "$INST64_X_APP_NAME_CAPS_X_REPO_NAME")" ||
        return $?
    fi
    package_prefix='X_PACKAGE_PREFIX_X'
    package_sufix='X_PACKAGE_SUFIX_X'
    # delete-me # Modify the following line to properly form the package name
    INST64_X_APP_NAME_CAPS_X_PACKAGES="${package_prefix}${INST64_X_APP_NAME_CAPS_X_VERSION}${INST64_X_APP_NAME_CAPS_X_PLATFORM}${package_sufix}"
  fi

# X_PREPARE_PLACEHOLDER_X
  bl64_arc_setup

# X_VERIFY_PLACEHOLDER_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'BINARY' ]]; then
    # example # "$INST64_X_APP_NAME_CAPS_X_CLI_PATH" --version
  fi

# X_INIT_PLACEHOLDER_X
  if bl64_lib_flag_is_enabled "$INST64_X_APP_NAME_CAPS_X_SYSTEM_WIDE"; then
    bl64_check_privilege_root ||
      return $?
  fi
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'BINARY'
