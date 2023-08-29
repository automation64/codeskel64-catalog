# X_CODE_PLACEHOLDER_1_X
export CNT64_LOCAL_BIN
export CNT64_OPT_ROOT

# X_CODE_PLACEHOLDER_2_X
export CNT64_X_APP_NAME_CAPS_X_PLATFORM="${CNT64_X_APP_NAME_CAPS_X_PLATFORM:-X_APP_PLATFORM_X}"
export CNT64_X_APP_NAME_CAPS_X_TARGET="${CNT64_X_APP_NAME_CAPS_X_TARGET:-${CNT64_OPT_ROOT}/X_APP_NAME_X}"
export CNT64_X_APP_NAME_CAPS_X_VERSION="${CNT64_X_APP_NAME_CAPS_X_VERSION:-latest}"

# X_CODE_PLACEHOLDER_3_X
  local repo_owner='X_REPO_OWNER_X'
  local repo_name='X_REPO_NAME_X'
  local package_prefix='X_PACKAGE_PREFIX_X'
  local package_sufix='X_PACKAGE_SUFIX_X'
  local package_name="X_PACKAGE_NAME_X"
  local work_path=''
  local app_target_mode='0755'
  local app_target_owner='root'
  local app_cli_mode='0755'
  local app_cli='X_APP_CLI_X'

  bl64_msg_show_task 'download application'
  work_path="$(bl64_fs_create_tmpdir)" || return $?
  if [[ "$CNT64_X_APP_NAME_CAPS_X_VERSION" == 'latest' ]]; then
    CNT64_X_APP_NAME_CAPS_X_VERSION="$(bl64_vcs_github_release_get_latest "$repo_owner" "$repo_name")" ||
      return $?
  fi

  bl64_rxtx_github_get_asset "$repo_owner" "$repo_name" "$CNT64_X_APP_NAME_CAPS_X_VERSION" "$package_name" "${work_path}/${package_name}" &&
    bl64_arc_open_tar "${work_path}/${package_name}" "${work_path}" ||
    return $?

  bl64_msg_show_task 'deploy application'
  bl64_fs_create_dir "$app_target_mode" "$app_target_owner" "$app_target_owner" "$CNT64_X_APP_NAME_CAPS_X_TARGET" &&
    bl64_fs_copy_files "$app_cli_mode" "$app_target_owner" "$app_target_owner" "$CNT64_X_APP_NAME_CAPS_X_TARGET" "${work_path}/${app_cli}" ||
    return $?

  bl64_msg_show_task "publish application to searchable path (${CNT64_LOCAL_BIN})"
  # shellcheck disable=SC2086
  bl64_fs_run_ln $BL64_FS_SET_LN_SYMBOLIC "${CNT64_X_APP_NAME_CAPS_X_TARGET}/${app_cli}" "${CNT64_LOCAL_BIN}/${app_cli}" ||
    return $?

  bl64_msg_show_task 'cleanup temporary files'
  bl64_fs_rm_tmpdir "$work_path"
  return 0

# X_CODE_PLACEHOLDER_4_X
  bl64_check_export 'CNT64_LOCAL_BIN' &&
    bl64_check_export 'CNT64_OPT_ROOT' &&
    bl64_arc_setup &&
    bl64_check_privilege_root
