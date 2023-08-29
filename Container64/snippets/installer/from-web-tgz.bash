# X_CODE_PLACEHOLDER_1_X
export CNT64_LOCAL_BIN
export CNT64_OPT_ROOT

# X_CODE_PLACEHOLDER_2_X
export CNT64_X_APP_NAME_CAPS_X_PLATFORM="${CNT64_X_APP_NAME_CAPS_X_PLATFORM:-X_APP_PLATFORM_X}"
export CNT64_X_APP_NAME_CAPS_X_SOURCE="${CNT64_X_APP_NAME_CAPS_X_SOURCE:-X_APP_REPO_X}"
export CNT64_X_APP_NAME_CAPS_X_TARGET="${CNT64_X_APP_NAME_CAPS_X_TARGET:-${CNT64_OPT_ROOT}/X_APP_NAME_X}"
export CNT64_X_APP_NAME_CAPS_X_VERSION="${CNT64_X_APP_NAME_CAPS_X_VERSION:-X_APP_VERSION_X}"

# X_CODE_PLACEHOLDER_3_X
  local package_prefix='X_PACKAGE_PREFIX_X'
  local package_sufix='X_PACKAGE_SUFIX_X'
  local package_name="X_PACKAGE_NAME_X"
# example #  local package_name="${package_prefix}_${CNT64_X_APP_NAME_CAPS_X_VERSION}_${CNT64_X_APP_NAME_CAPS_X_PLATFORM}.${package_sufix}"
  local package_url="X_PACKAGE_URL_X"
# example #  local package_url="${CNT64_X_APP_NAME_CAPS_X_SOURCE}/v${CNT64_X_APP_NAME_CAPS_X_VERSION}"
  local work_path=''
  local app_target_mode='0755'
  local app_target_owner='root'
  local app_cli_mode='0755'
  local app_cli='X_APP_CLI_X'

  bl64_msg_show_task 'download application'
  work_path="$(bl64_fs_create_tmpdir)" || return $?
  bl64_rxtx_web_get_file "${package_url}/${package_name}" "${work_path}/${package_name}" &&
# example #    bl64_arc_open_tar "${work_path}/${package_name}" "${work_path}" ||
# example #    bl64_arc_open_zip "${work_path}/${package_name}" "${work_path}" ||
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
