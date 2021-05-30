# IntelTurboBooster
*A script that makes it easier to change Intel® CPU's Turbo Boost settings and clock speed.*
### DISCLAIMER
**This script is only for Intel® CPUs not any other!**

**Use this script at your own risk! I am not responsible for any malfunction on your system!**

### Attention
- Make sure your CPU model is supporting Turbo Boost Technology.
- Make sure you enabled Intel Turbo Boost Technology from BIOS.
- Make sure you're running this script with root privileges.
### Getting Started
```bash
git clone https://github.com/f4T1H21/IntelTurboBooster.git
cd IntelTurboBooster
chmod +x booster.sh
sudo bash ./booster.sh --help
```

### Usage
```
Usage: sudo bash booster.sh <MinPercentage> <MaxPercentage> [OPTIONS]
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
    sudo bash booster.sh         # Show the current CPU clock speed and Turbo Boost status.
    sudo bash booster.sh 50 100  # Set CPU to run at a min of %50 to a max of %100 of its capacity.
    sudo bash booster.sh 30 70 e # Set CPU to run at a min of %30 to a max of %70 of its capacity, enable Turbo Boost.
```
### Example ss (PoC)
![poc](https://github.com/f4T1H21/IntelTurboBooster/blob/main/src/poc.png)

### Troubleshooting
*You made sure the clauses in the Attention section but still face errors?*
#### Possible Error #1: No Intel® Turbo Boost Technology detected on your system!
![err1](https://github.com/f4T1H21/IntelTurboBooster/blob/main/src/err1.png)

That's because either you don't have the default Turbo Boost directory ``/sys/devices/system/cpu/intel_pstate/`` or you do have it but some of the following files which should be in that directory are missing.
- ``min_perf_pct``
- ``max_perf_pct``
- ``no_turbo``

**Solution:**
You have to find your Turbo Boost directory on your system and change the directory on the [code](https://github.com/f4T1H21/IntelTurboBooster/blob/a6036b3af70ed13c70aab08833375d2f4d91e9bb/booster.sh#L10) with yours. Also create missing files as root. 

#### Possible Error #2: Failed to enable Turbo Boost, operation not permitted!
![err2](https://github.com/f4T1H21/IntelTurboBooster/blob/main/src/err2.png)

This is the error when your hardware is NOT able to run Turbo Boost anymore. That's because of your hardware's insufficient performance and mostly temporary. Also you can still change your CPU's clock speed but if you don't enable Turbo Boost, even you set 100 to maximum, CPU will run at its base clock speed. 

**Solution:** You can fix it by charging your laptop and kinda things if it is temporary for you. But if your hardware can't even afford enabling Turbo Boost once, then I don't think this have a solution other than using more high performance hardwares.

Thanks and constructive feedback is appreciated!

***Written by f4T1H***
