#!/usr/bin/env bash
# shell-scripts/shebang.sh

# shebang.sh
#	Checks if bash sctips contain a shebang on line one
#	Check if file exists and is a bash scrip
#	Checks for "#!" via grep  


set -euo pipefail
# -e exit if any command returns non-zero status code
# -u prevent using undefined variables
# -o pipefail force pipelines to fail on first non-zero status code


FATAL="\\033[1;31mFATAL\\033[0m"
# WARNING="\\033[1;33mWARNING\\033[0m"
PASS="\\033[1;32mPASS\\033[0m"
INFO="\\033[1;36mINFO\\033[0m"


usage () {

	echo -e "Usage: ./shebang.sh {file1} {file2} {file...}"
	echo -e "[${INFO}] ./shebang.sh * checks all files in current directory "

}


check_if_bash () {

	for file_to_check in "$@"; do
		
		if [ ! -f "${file_to_check}" ]; then
			# Check if file exists
			echo -e "[${FATAL}] ${file_to_check} does not exist"
		else

			if file "${file_to_check}" | grep --quiet "shell" || file "${file_to_check}" | grep --quiet "bash"; then
				bash_files+=("${file_to_check}")
			else
				echo -e "[${INFO}] ${file_to_check} is not a bash script"
				
			fi
		fi
	done

}


check_for_shebang () {


	for file in "${bash_files[@]}"; do

		if head -1 "${file}" | grep --quiet "#\\!"; then
			echo -e "[${PASS}] ${file} contains a shebang"
		else
			echo -e "[${FATAL}] ${file} does not have a shebang"
		fi
	done

	echo -e "[${INFO}] ${#bash_files[@]} files checked"
}


main () {

	if [[ $# -eq 0 ]] ; then
		# If no args then print help
    	usage
    	exit 1
	fi

	bash_files=()

	check_if_bash "$@"

	if [ ${#bash_files[@]} -eq 0 ]; then
		# If ERRORS empty then 
		echo -e "[${INFO}] No Bash files to check"
		exit 0
	else
		check_for_shebang
	fi
}

main "$@"
