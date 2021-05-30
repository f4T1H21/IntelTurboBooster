#!/bin/bash
######                       ب                        #######
## Intel® Turbo Boost and clock speed editor script by f4T1H.
## See https://github.com/f4T1H21/IntelTurboBooster
## Constructive feedback is appreciated.
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi
directory="/sys/devices/system/cpu/intel_pstate/" # The default location for intel_pstate.
if ! [[ -d $directory || -f "${directory}min_perf_pct" && -f "${directory}max_perf_pct" && -f "${directory}no_turbo" ]]; then # Check if there are Turbo Boost directory and files to change settings.
    cat - << EOS
${version}
...................................................................................................
[E] Fatal Error: No Intel® Turbo Boost Technology detected on your system!
Your system either doesn't have intel_pstate directory or there are files missing in intel_pstate.
The default location for intel_pstate is: /sys/devices/system/cpu/intel_pstate/
If it exist but not in its default directory, please change the directory location inside the code.
[i] See https://github.com/f4T1H21/IntelTurboBooster for more information.
...................................................................................................
EOS
    exit 16
fi
arg1=$1
arg2=$2
arg3=$3
values=()
for number in {1..100}; do values+=($number);done # Add every number from 1 to 100 in an array so as to prevent any other value that would be given as percentage.
options=("e" "d") # Again an array to check turbo boost options.
version="Intel® Turbo Booster v1.0 <Written by f4T1H>"
read -r -d '' helpmenu <<- EOS
${version}
# See https://github.com/f4T1H21/IntelTurboBooster for more information.
[!] This script is only for Intel® CPUs which supporting Turbo Boost Technology not for any other.
[!] Use at your own risk, I am not responsible for any malfunction.
A script that makes it easier to change Intel® Turbo Boost settings and clock speed percentage.

Usage: sudo ./booster.sh <MinPercentage> <MaxPercentage> [OPTIONS]
FLAGS:
    -h, --help      Print this help menu and exit.
    -v, --version   Print version information and exit.
OPTIONS:
    e   Enable Intel® Turbo Boost technology.
    d   Disable Intel® Turbo Boost technology.
ARGUMENTS:
    <MinPercentage> Set minimum CPU clock speed between %1 - %100.
    <MaxPercentage> Set maximum CPU clock speed between %1 - %100.
EXAMPLES:
    sudo ./booster.sh         # Show the current CPU clock speed and Turbo Boost status.
    sudo ./booster.sh 50 100  # Set CPU to run at a min of %50 to a max of %100 of its capacity.
    sudo ./booster.sh 30 70 e # Set CPU to run at a min of %30 to a max of %70 of its capacity, enable Turbo Boost.
EOS
read -d '' error <<- EOS # The error string for handling hardware errors.
.....................................................................................
[E] Error: Failed to enable Turbo Boost, operation not permitted!
In most cases this happens when hardware is NOT able to write into Turbo Boost files.
You can still change clock speed and look your current CPU status.
[i] See https://github.com/f4T1H21/IntelTurboBooster for more information.
.....................................................................................
EOS

if [[ $arg1 = "-h" && $arg2 = "" && $arg3 = "" || $arg1 = "--help" && $arg2 = "" && $arg3 = "" ]]; then # Start checking arguments.
    echo "$helpmenu"
    exit 0

elif [[ $arg1 = "-v" && $arg2 = "" && $arg3 = "" || $arg1 = "--version" && $arg2 = "" && $arg3 = "" ]]; then
    echo "$version"
    exit 0

elif [[ " ${values[@]} " =~ " ${arg1} " && " ${values[@]} " =~ " ${arg2} " ]]; then
    echo -e "$version \n"
    if [[ ${arg3} != "" ]]; then
        if [[ ${arg3} = "e" ]]; then
        sudo echo 0 > ${directory}no_turbo && echo "[+] Turbo Boost Enabled!" || echo "$error" # Enable turbo boost by writing into no_turbo file.
        elif [[ ${arg3} = "d" ]]; then
        sudo echo 1 > ${directory}no_turbo && echo "[+] Turbo Boost Disabled!"|| echo "$error" # Disable turbo boost by writing into no_turbo file.
        else
        echo "[E] Fatal Error: Only 'e' or 'd' can be given as the third argument! More info in help menu."
        exit 16
        fi
    fi
    echo ${arg1} | sudo tee ${directory}min_perf_pct 1>/dev/null && echo "[+] Set minimum CPU clock speed: ${arg1}" || echo "[E] There's an unexpected error!" # Set minimum clock speed by writing into min_perf_pct file.
    echo ${arg2} | sudo tee ${directory}max_perf_pct 1>/dev/null && echo "[+] Set maximum CPU clock speed: ${arg2}" || echo "[E] There's an unexpected error!" # Set minimum clock speed by writing into max_perf_pct file.
    exit 0

elif [[ $arg1 = "" && $arg2 = "" && $arg3 = "" ]]; then # Read current status from file and write under headers.
    cat - << EOS
${version}

Current status of CPU;
Minimum clock speed percentage: %$(cat ${directory}min_perf_pct)
Maximum clock speed percentage: %$(cat ${directory}max_perf_pct)
Intel® Turbo Boost Technology : $(if [ $(cat ${directory}no_turbo) = "0" ]; then echo "On"; else echo "Off"; fi)
EOS
    exit 0

else
    cat - << EOS
WRONG USAGE! "sudo ./booster.sh --help" for more information.
Usage: sudo ./booster.sh <MinPercentage> <MaxPercentage> [OPTIONS]
$version
EOS
    exit 16
fi
