# Snippet: 1.0.0
# X_CODE_PLACEHOLDER_2_X
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-KREW}"

export INST64_X_APP_NAME_CAPS_X_KREW_BIN="${HOME}/.krew/bin/kubectl-krew"
export INST64_X_APP_NAME_CAPS_X_K8S_KUBECONFIG="${INST64_X_APP_NAME_CAPS_X_K8S_KUBECONFIG:-$BL64_VAR_DEFAULT}"

# X_STAND_ALONE_FUNCTIONS_X #
function inst64_X_APP_NAME_X_install_krew_package() {
  bl64_dbg_app_show_function
  local packages=''

  bl64_msg_show_task 'deploy application to local kubectl'
  packages="$(inst64_X_APP_NAME_X_select_packages)" ||
    return $?
  # shellcheck disable=SC2086
  bl64_k8s_run_kubectl_plugin \
    "$INST64_X_APP_NAME_CAPS_X_K8S_KUBECONFIG"
    krew install \
    $packages
}

# X_CODE_PLACEHOLDER_3_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'KREW' ]]; then
    inst64_X_APP_NAME_X_install_krew_package
  fi

# X_CODE_PLACEHOLDER_8_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'KREW' ]]; then
    packages='X_PACKAGE_LIST_X'
  fi

# X_CODE_PLACEHOLDER_6_X
  bl64_k8s_setup

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' \
      "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'KREW' &&
    bl64_check_privilege_not_root &&
    bl64_check_command "$INST64_X_APP_NAME_CAPS_X_KREW_BIN"

