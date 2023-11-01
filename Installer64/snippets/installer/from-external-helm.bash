# Snippet: 1.0.0
# X_STAND_ALONE_FUNCTIONS_X #

function inst64_X_APP_NAME_X_add_helm_repo() {
  bl64_dbg_app_show_function
  bl64_hlm_repo_add "$INST64_X_APP_NAME_CAPS_X_HELM_REPO" "$INST64_X_APP_NAME_CAPS_X_HELM_SOURCE"
}

function inst64_X_APP_NAME_X_install_helm_chart() {
  bl64_dbg_app_show_function
  bl64_msg_show_task 'deploy application to K8S'
  inst64_X_APP_NAME_X_add_helm_repo &&
    bl64_hlm_chart_upgrade \
      "$INST64_X_APP_NAME_CAPS_X_K8S_KUBECONFIG" \
      "$INST64_X_APP_NAME_CAPS_X_K8S_NAMESPACE" \
      "$INST64_X_APP_NAME_CAPS_X_HELM_CHART" \
      "${INST64_X_APP_NAME_CAPS_X_HELM_REPO}/${INST64_X_APP_NAME_CAPS_X_HELM_CHART}"
}

# X_CODE_PLACEHOLDER_2_X
# Installation method
export INST64_X_APP_NAME_CAPS_X_METHOD="${INST64_X_APP_NAME_CAPS_X_METHOD:-HELM}"
# Full path to the kubectl config file with valid credentials
export INST64_X_APP_NAME_CAPS_X_K8S_KUBECONFIG="{INST64_X_APP_NAME_CAPS_X_K8S_KUBECONFIG:-${HOME}/.kube/config}"

export INST64_X_APP_NAME_CAPS_X_HELM_CHART='X_CHART_NAME_X'
export INST64_X_APP_NAME_CAPS_X_HELM_REPO='X_REPO_NAME_X'
export INST64_X_APP_NAME_CAPS_X_HELM_SOURCE='X_REPO_SOURCE_X'
export INST64_X_APP_NAME_CAPS_X_K8S_NAMESPACE='argocd'

# X_CODE_PLACEHOLDER_3_X
  if [[ "$INST64_X_APP_NAME_CAPS_X_METHOD" == 'HELM' ]]; then
    inst64_X_APP_NAME_X_install_helm_chart
  fi

# X_CODE_PLACEHOLDER_4_X
  bl64_os_check_version \
    "${X_BL64_OS_ID_X}" &&
    bl64_fmt_check_value_in_list 'invalid installation method for the parameter INST64_X_APP_NAME_CAPS_X_METHOD' "$INST64_X_APP_NAME_CAPS_X_METHOD" \
      'HELM' &&
    bl64_check_privilege_not_root &&
    bl64_k8s_setup &&
    bl64_hlm_setup
