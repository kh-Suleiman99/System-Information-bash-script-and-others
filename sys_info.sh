#!/bin/bash
# sys_info.sh: Program to output system informations to an html page

PROGNAME=$(basename $0)
TITLE="System Information Report for $HOSTNAME"
CURRENT_TIME="$(date +"%D %r")"
TIMESTAMP="Generated $CURRENT_TIME, by $USER"

report_uptime () {
	cat <<- _EOF_
		<h2>System Uptime</h2>
		<pre>$(uptime)</pre>
		_EOF_
	return
}

report_disk_Space () {
	cat <<- _EOF_
		<h2>Disk Space Utilization</h2>
		<pre>$(df -h)</pre>
		_EOF_
	return
}

report_home_space () {
	local format="%8s%10s%10s\n"
	local i dir_list user_name total_files total_dirs total_size 
	
	if [[ "$(id -u)" -eq 0 ]]; then
		dir_list=/home/*
		user_name="All users"
	else
		dir_list="$HOME"
		user_name="$USER"
	fi

	echo "<h2>Home Space Utilization ($user_name)</h2>"

	for i in $dir_list; do
		total_files="$(find "$i" -type f | wc -l)"
		total_dirs="$(find "$i" -type d | wc -l)"
		total_size="$(du -sh "$i" | cut -f 1)"
		echo "<h3>$i</h3>"
		echo "<pre>"
		printf "$format" "Dirs" "Files" "Size"
		printf "$format" "----" "-----" "----"
		printf "$format" "$total_dirs" "$total_files" "$total_size"
		echo "</pre>"
	done
return
}


usage () {
	echo "$PROGNAME: usage: $PROGNAME [-f file | -i]"
}

# To creat an html page
write_html_page () {
	cat <<- _EOF_
	<html>
		<head>
			<title>$TITLE</title>
		</head>
		<body>
			<h1>${TITLE}..</h1>
			<p>$TIMESTAMP</p>
			$(report_uptime)
			$(report_disk_Space)
			$(report_home_space)
		</body>
	</html>
	_EOF_
	return
}

# process command line options
interactive=
filename=

while [[ -n "$1" ]]; do
	case "$1" in 
		-f | --file)		shift
							filename="$1"
							;;
		-i | --interactive)	interactive=1
							;;
		-h | --help)		usage
							exit
							;;
		*)					usage >&2
							exit
							;;
	esac
	shift
done


# interactive mode
if [[ -n "$interactive" ]]; then
	while true; do
		read -p "Enter name of output file: " filename
		if [[ -e "$filename" ]]; then
			read -p "'$filename' exists. Overwrite? [y/n/q] > "
			case "$REPLY" in
				Y|y)	break
					 	;;
				Q|q) 	echo "Program terminated."
					 	exit
					 	;;
				*)  	continue
						;;
			esac
		elif [[ -z "$filename" ]]; then
			continue
		else
			break
		fi
	done
fi

# output html page
if [ -n "$filename" ]; then
	if touch "$filename" && [[ -f "$filename" ]]; then
		write_html_page > "$filename"
	
	else
		echo "$PROGNAME: Cannot write file '$filename'" >&2
		exit 1
	fi
else 
	write_html_page
fi
