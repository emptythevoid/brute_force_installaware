# Brute Force InstallAware
A script to help brute force password on InstallAware .exe files

This is a quick and dirty script to (ab)use 7z to brute force an InstallAware .exe file using a wordlist.

InstallAware files are basically zip files that use 7zip's AES256 passwords, just as if it were done on a proper zip file. Unfortunately, the normal tools (such as fcrackzip) will fail to work as they expect a zip file.  Fortunately, 7z is able to handle this without issue.

##Usage:

brute_installware.sh <installware .exe file> <wordlist>

If a password is successfully found, the script will report back the password that worked, and it will automatically extract the contents of the .exe in the working directory.

##Requirements:

p7zip-full

##Limitations:

-Runs as a single process

-7z will likely extract folder structure and files of zero size
