#!/bin/bash
set -e

KARABINER_HOME="${KARABINER_HOME:-$HOME/.config/karabiner}"

dry_run=0
karabiner_mods_path="$KARABINER_HOME/assets/complex_modifications"

info () {
  echo -e "$(tput setaf 4)$(tput bold)$@$(tput sgr0)"
}

success () {
  echo -e "$(tput setaf 2)$@$(tput sgr0)"
}

fail () {
  echo -e "$(tput setaf 1)$@$(tput sgr0)"
  exit 1
}

parse_options () {
  while [[ $# -gt 0 ]]; do
    case $1 in
      --debug)
        set -x
        ;;
      -n|--dry-run)
        dry_run=1
        ;;
    esac
    shift
  done
}

check_mods_dir_exists () {
  if [[ ! -d "$karabiner_mods_path" ]]; then
    fail "Karabiner's modifications path not found at '$karabiner_mods_path'"
  fi
}

install_mods () {
  pushd "$(dirname $0)/.." > /dev/null
  local cwd=$(pwd -P)
  for file in modifications/*.json; do
    if [[ -f "$file" ]]; then
      local target="$karabiner_mods_path/$(basename $file)"

      if [[ ! -L "$target" ]]; then
        info "# ln -sfv $cwd/$file $target"

        if [[ $dry_run -eq 0 ]]; then
          ln -sfv "$cwd/$file" "$target"
        fi
      fi
    fi
  done
  popd > /dev/null
}

parse_options "$@"
check_mods_dir_exists
install_mods
success 'Done!'
