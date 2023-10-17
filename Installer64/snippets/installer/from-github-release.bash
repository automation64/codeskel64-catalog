# Snippet: 2.0.0
# X_STAND_ALONE_FUNCTIONS_X #

function inst64_X_APP_NAME_X_install_binary_release() {
  bl64_dbg_app_show_function
  local package_prefix='X_PACKAGE_PREFIX_X'
  local package_sufix='X_PACKAGE_SUFIX_X'
  local package_name=''
  local work_path=''
  local app_target_mode='0755'
  local app_target_owner='root'
  local app_cli_mode='0755'
  local app_cli='X_APP_CLI_X'

  bl64_msg_show_task 'download application'
  work_path="$(bl64_fs_create_tmpdir)" || return $?
  if [[ "$INST64_X_APP_NAME_CAPS_X_VERSION" == 'latest' ]]; then
    INST64_X_APP_NAME_CAPS_X_VERSION="$(bl64_vcs_github_release_get_latest "$INST64_X_APP_NAME_CAPS_X_REPO_OWNER" "$INST64_X_APP_NAME_CAPS_X_REPO_NAME")" ||
      return $?
  fi
  # delete-me # Modify the following line to properly form the package name
  package_name="${package_prefix}${INST64_X_APP_NAME_CAPS_X_VERSION}${INST64_X_APP_NAME_CAPS_X_PLATFORM}${package_sufix}"

  bl64_rxtx_github_get_asset "$INST64_X_APP_NAME_CAPS_X_REPO_OWNER" "$INST64_X_APP_NAME_CAPS_X_REPO_NAME" "$INST64_X_APP_NAME_CAPS_X_VERSION" "$package_name" "${work_path}/${package_name}" &&
    bl64_arc_open_tar "${work_path}/${package_name}" "${work_path}" ||
    return $?

  bl64_msg_show_task 'deploy application'
  bl64_fs_create_dir "$app_target_mode" "$app_target_owner" "$app_target_owner" "$INST64_X_APP_NAME_CAPS_X_TARGET" &&
    bl64_fs_copy_files "$app_cli_mode" "$app_target_owner" "$app_target_owner" "$INST64_X_APP_NAME_CAPS_X_TARGET" "${work_path}/${app_cli}" ||
    return $?

  bl64_msg_show_task "publish application to searchable path (${INST64_LOCAL_BIN})"
  # shellcheck disable=SC2086
  bl64_fs_create_symlink "${INST64_X_APP_NAME_CAPS_X_TARGET}/${app_cli}" "${INST64_LOCAL_BIN}/${app_cli}" "$BL64_VAR_ON" ||
    return $?

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_rm_tmpdir "$work_path"
  return 0
}

# X_CODE_PLACEHOLDER_2_X
export INST64_X_APP_NAME_CAPS_X_PLATFORM="${INST64_X_APP_NAME_CAPS_X_PLATFORM:-X_APP_PLATFORM_X}"
export INST64_X_APP_NAME_CAPS_X_TARGET="${INST64_X_APP_NAME_CAPS_X_TARGET:-${INST64_OPT_ROOT}/X_APP_NAME_X}"
export INST64_X_APP_NAME_CAPS_X_VERSION="${INST64_X_APP_NAME_CAPS_X_VERSION:-latest}"
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-BINARY}"

export INST64_X_APP_NAME_CAPS_X_REPO_NAME='X_REPO_NAME_X'
export INST64_X_APP_NAME_CAPS_X_REPO_OWNER='X_REPO_OWNER_X'

# X_CODE_PLACEHOLDER_3_X
  inst64_X_APP_NAME_X_install_binary_release

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'BINARY' &&
    bl64_arc_setup &&
    bl64_check_privilege_root
