#! /bin/bash

exe="$1"
wordlist="$2"

# Function to make a return code
# https://unix.stackexchange.com/questions/387897/is-there-a-simple-test-for-anything-printed-on-stderr-in-shell-bash
fail_if_stderr() (
  rc=$({
    ("$@" 2>&1 >&3 3>&- 4>&-; echo "$?" >&4) |
    grep '^' >&2 3>&- 4>&-
  } 4>&1)
  err=$?
  [ "$rc" -eq 0 ] || exit "$rc"
  [ "$err" -ne 0 ] || exit 125
) 3>&1

# Loop over wordlist
# https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash
# Handle empty return status
# https://serverfault.com/questions/7503/how-to-determine-if-a-bash-variable-is-empty
status=0

while IFS="" read -r p || [ -n "$p" ]
  do
    printf '%s\n' "$p"
    status=$(fail_if_stderr 7z e -aoa "-p$p" $1 > /dev/null || echo $?)
    echo $status
    if [ -z $status ]
    then
      echo "Password is $p"
      exit 0
    fi
done < $wordlist



# run the command and save the return code
#status=$(fail_if_stderr 7z e -aoa "-paBayezid-i Bistami" $1 > /dev/null || echo $?)
#status=$(7z e -aoa "-paBayezid-i Bistami" InstallAware_X16.exe 2>&1 > /dev/null)
#echo $status


