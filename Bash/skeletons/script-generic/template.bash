#!/usr/bin/env bash
# X_SCRIPT_HEADER_PLACEHOLDER_X

#
# Imports
#

# source X_PATH_LIBRARY_X

#
# Globals
#

readonly X_APP_NAMESPACE_X_X_EXPORT_RO_X=''
# Example # export X_APP_NAMESPACE_X_X_EXPORT_X=''

#
# Functions
#

function X_APP_NAMESPACE_X_X_FUNCTION_COMMAND_X() {

  local flag="$1"
  local option="$2"
  local status=1

  return $status

}

#######################################
# Check requirements and prerequisites
#
# Arguments:
#   None
# Outputs:
#   Failed check description
# Returns:
#   0: check ok
#   1: requirements not met
#######################################
function X_APP_NAMESPACE_X_check() {

  local result=1

  return $result

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

  :

}

#
# Main
#

declare X_APP_NAMESPACE_X_status=1
declare X_APP_NAMESPACE_X_command=''
declare X_APP_NAMESPACE_X_X_OPTION_X=''
declare X_APP_NAMESPACE_X_X_FLAG_X='0'

[[ $# = 0 ]] && X_APP_NAMESPACE_X_help && exit 1
while getopts ':xy:zh' X_APP_NAMESPACE_X_option; do
  case "$X_APP_NAMESPACE_X_option" in
  x) X_APP_NAMESPACE_X_command='X_APP_NAMESPACE_X_X_FUNCTION_COMMAND_X' ;;
  y) X_APP_NAMESPACE_X_X_OPTION_X="$OPTARG" ;;
  z) X_APP_NAMESPACE_X_X_FLAG_X='1' ;;
  h) X_APP_NAMESPACE_X_help && exit ;;
  \?) X_APP_NAMESPACE_X_help && exit 1 ;;
  esac
done
[[ -z "$X_APP_NAMESPACE_X_command" ]] && X_APP_NAMESPACE_X_help && exit 1
[[ -z "$X_APP_NAMESPACE_X_X_OPTION_X" ]] && X_APP_NAMESPACE_X_help && exit 1
X_APP_NAMESPACE_X_check || exit 1

"$X_APP_NAMESPACE_X_command" "$X_APP_NAMESPACE_X_X_FLAG_X" "$X_APP_NAMESPACE_X_X_OPTION_X"

X_APP_NAMESPACE_X_status=$?
exit $X_APP_NAMESPACE_X_status
