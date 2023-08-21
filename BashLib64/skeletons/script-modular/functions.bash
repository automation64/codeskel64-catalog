#
# Functions
#

# X_FUNCTION_HEADER_PLACEHOLDER_X
function X_APP_NAMESPACE_X_X_FUNCTION_COMMAND1_X() {
  bl64_dbg_app_show_function "@"
  local option="$1"
  local flag="$2"
  local -i status=1

  # delete-me # bl64_check_parameter 'option' || return 1
  :
  status=$?

  return $status
}

# X_FUNCTION_HEADER_PLACEHOLDER_X
function X_APP_NAMESPACE_X_X_FUNCTION_COMMAND2_X() {
  bl64_dbg_app_show_function
  local -i status=1

  :
  status=$?

  return $status
}

#######################################
# Initialize environment
#
# Arguments:
#   None
# Outputs:
#   Initializacion progress messages
# Returns:
#   0: initialization ok
#   >: failed to initialize
#######################################
function X_APP_NAMESPACE_X_initialize() {
  bl64_dbg_app_show_function "@"
  local command="$1"

  bl64_check_parameter 'command' ||
    { X_APP_NAMESPACE_X_help && return 1; }

  return 0
}

#######################################
# Show script usage description
#
# Arguments:
#   None
# Outputs:
#   Command line format and description
# Returns:
#   0
#######################################
function X_APP_NAMESPACE_X_help() {
  bl64_msg_show_usage \
    '-x|-w [-y X_OPT1_X] [-z] [-V Verbose] [-D Debug] [-h]' \
    'X_APP_INFO_X' \
    '
    -x         :
    -w         :
    ' '
    -z         :
    -h         : Show help
    ' '
    -y X_OPT1_X:
    -V Verbose : Set verbosity level. Format: one of BL64_MSG_VERBOSE_*
    -D Debug   : Enable debugging mode. Format: one of BL64_DBG_TARGET_*
    '
}
