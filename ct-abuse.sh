#!/usr/bin/env bash
# shell-scripts/ct-abuse.sh

# ct-abuse.sh
# 	Enumerate HTTPS enabled subdomains via Certificate Transparency 


set -euo pipefail
# -e exit if any command returns non-zero status code
# -u prevent using undefined variables
# -o pipefail force pipelines to fail on first non-zero status code


# Define output messages
TARGET="\\033[1;36m[Target]\\033[0m"
SUBDOMIANS="\\033[1;33m[Subdomains]\\033[0m"
TOTAL_SUBDOMIANS="\\033[1;32m[Total Subdomains]\\033[0m"


usage () {
	
	echo -e "Usage: ./ct-abuse.sh {target_domain}"
}


get_subdomains () {

	local subdomains=()

	# shellcheck disable=SC2207
	subdomains=($(curl --silent "https://crt.sh/?q=%25.${1}&output=json" \
				| grep -Eo '"name_value":(\d*?,|.*?[^\\]",)' \
				| awk -F '"' '{print $4}' \
				| sort -u))
	# grep regex from: https://stackoverflow.com/a/6852427

	echo -e "${TARGET} ${1}"
	echo -e "${SUBDOMIANS}:"

	for result in "${subdomains[@]}"; do
		echo "		${result}"
	done

	echo -e "${TOTAL_SUBDOMIANS} ${#subdomains[@]}"
}


main () {

	local target_domain=${1:-""}

	if [[ $# -eq 0 ]] ; then
		# If no args then print help
    	usage
    	exit 1
	fi

	get_subdomains "${target_domain}"
}

main "$@"
