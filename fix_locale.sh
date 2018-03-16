#!/usr/bin/env bash
# shell-scripts/fix_locale.sh

# fix_locale.sh
# 	Fixes errors like "-bash: warning: setlocale: LC_ALL: cannot change locale (en_GB.utf8)"


set -euo pipefail
# -e exit if any command returns non-zero status code
# -u prevent using undefined variables
# -o pipefail force pipelines to fail on first non-zero status code

FATAL="\\033[1;31mFATAL\\033[0m"
WARNING="\\033[1;33mWARNING\\033[0m"
PASS="\\033[1;32mPASS\\033[0m"
INFO="\\033[1;36mINFO\\033[0m"

run_locale-gen () {

	echo -e "[${INFO}] Running 'sudo locale-gen'"
	sleep 2

	if sudo locale-gen ; then
		echo -e "[${PASS}] 'sudo locale-gen' successful"
	else
		echo -e "[${FATAL}] 'sudo locale-gen' failed"
		exit 1
	fi

}

run_dpkg_reconfigure_locales () {

	echo -e "[${INFO}] Running 'sudo dpkg-reconfigure locales'"
	sleep 2

	if sudo dpkg-reconfigure locales ; then
		echo -e "[${PASS}] 'sudo dpkg-reconfigure locales' successful"
	else
		echo -e "[${FATAL}] 'sudo dpkg-reconfigure locales' failed"
		exit 1
	fi

}



main () {
	
	echo -e "[${WARNING}] Executes 'sudo locale-gen' and 'sudo dpkg-reconfigure locales'"
	echo -e "[${INFO}] en_GB.UTF-8 is Locale #130"

	sleep 2

	run_locale-gen
	run_dpkg_reconfigure_locales
}

main "$@"

