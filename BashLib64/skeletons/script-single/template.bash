#!/usr/bin/env bash
# X_SCRIPT_HEADER_PLACEHOLDER_X

# shellcheck source=SCRIPTDIR/bashlib64.bash
#source "${X_PATH_TO_LIB_X}/bashlib64.bash" || { echo "Error: unable to load bashlib64" && exit 1; }
source "./bashlib64.bash" || { echo "Error: unable to load bashlib64" && exit 1; }

#
# Globals
#
# RemoveMe # Use this section to declare global variables only. Settings are done in the function X_APP_NAMESPACE_X_initialize
# RemoveMe # If there are too many definitions consider using a separated script.env file that can be sourced

# Example # export X_APP_NAMESPACE_X_X_EXPORT_RO_X=''
# Example # export X_APP_NAMESPACE_X_X_EXPORT_X=''

#
# Functions
#

function X_APP_NAMESPACE_X_X_FUNCTION_COMMAND1_X() {
  bl64_dbg_app_show_function "@"
  local option="$1"
  local flag="$2"
  local -i status=1

  # RemoveMe # bl64_check_parameter 'option' || return 1
  :
  status=$?

  return $status
}

function X_APP_NAMESPACE_X_X_FUNCTION_COMMAND2_X() {
  bl64_dbg_app_show_function
  local -i status=1

  :
  status=$?

  return $status
}

# RemoveMe # Use this function to set global values only.
function X_APP_NAMESPACE_X_initialize() {
  bl64_dbg_app_show_function "@"
  local command="$1"

  bl64_check_parameter 'command' ||
    { X_APP_NAMESPACE_X_help && return 1; }

  return 0
}

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

#
# Main
#

declare -i X_APP_NAMESPACE_X_status=1
declare X_APP_NAMESPACE_X_debug="$BL64_DBG_TARGET_NONE"
declare X_APP_NAMESPACE_X_verbose="$BL64_MSG_VERBOSE_APP"
declare X_APP_NAMESPACE_X_option=''
declare X_APP_NAMESPACE_X_command="$BL64_VAR_NULL"
declare X_APP_NAMESPACE_X_X_OPTION_X=''
declare X_APP_NAMESPACE_X_X_FLAG_X='0'

(($# == 0)) && X_APP_NAMESPACE_X_help && exit 1
while getopts ':xwy:zV:D:h' X_APP_NAMESPACE_X_option; do
  case "$X_APP_NAMESPACE_X_option" in
  x) X_APP_NAMESPACE_X_command='X_APP_NAMESPACE_X_X_FUNCTION_COMMAND1_X' ;;
  w) X_APP_NAMESPACE_X_command='X_APP_NAMESPACE_X_X_FUNCTION_COMMAND2_X' ;;
  y) X_APP_NAMESPACE_X_X_OPTION_X="$OPTARG" ;;
  z) X_APP_NAMESPACE_X_X_FLAG_X='1' ;;
  V) X_APP_NAMESPACE_X_verbose="$OPTARG" ;;
  D) X_APP_NAMESPACE_X_debug="$OPTARG" ;;
  h) X_APP_NAMESPACE_X_help && exit 0 ;;
  *) X_APP_NAMESPACE_X_help && exit 1 ;;
  esac
done
bl64_dbg_set_level "$X_APP_NAMESPACE_X_debug" && bl64_msg_set_level "$X_APP_NAMESPACE_X_verbose" || exit $?
X_APP_NAMESPACE_X_initialize "$X_APP_NAMESPACE_X_command" || exit $?

bl64_msg_show_batch_start "$X_APP_NAMESPACE_X_command"
case "$X_APP_NAMESPACE_X_command" in
'X_APP_NAMESPACE_X_X_FUNCTION_COMMAND1_X') "$X_APP_NAMESPACE_X_command" "$X_APP_NAMESPACE_X_X_FLAG_X" "$X_APP_NAMESPACE_X_X_OPTION_X" ;;
'X_APP_NAMESPACE_X_X_FUNCTION_COMMAND2_X') "$X_APP_NAMESPACE_X_command" ;;
*) bl64_check_alert_parameter_invalid "$X_APP_NAMESPACE_X_command" ;;
esac
X_APP_NAMESPACE_X_status=$?

bl64_msg_show_batch_finish $X_APP_NAMESPACE_X_status "$X_APP_NAMESPACE_X_command"
exit $X_APP_NAMESPACE_X_status
