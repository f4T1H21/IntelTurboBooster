# IntelTurboBooster
_A tool that makes it easier to change Intel® CPU's Turbo Boost settings and clock speed._

<a href=https://www.buymeacoffee.com/f4T1H>
  <img src="https://github.com/f4T1H21/f4T1H21/blob/main/support.png" width="221" height="40" alt="Support">
  </img>
</a>
<br>

---

## DISCLAIMER
__This tool is only for Intel® CPUs supporting intel_pstate driver!__<br>
_intel_pstate driver is not being supported by i5 and lower models than i5._

__Use at your own risk! I am not responsible for any malfunction on your system!__

## Attention
- Make sure your CPU model is i7 or a higher model than i7.
- Make sure you enabled Intel Turbo Boost Technology from BIOS.
- Make sure you're running this tool with root privileges.
## Getting Started
```bash
git clone https://github.com/f4T1H21/IntelTurboBooster.git
cd IntelTurboBooster
chmod +x booster.sh
sudo ./booster.sh --help
```
## Usage
```
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
    sudo ./booster.sh
      # Show the current CPU clock speed and Turbo Boost status.
    sudo ./booster.sh 50 100
      # Set CPU to run at a minimum of %50 to a maximum of %100 of its capacity.
    sudo ./booster.sh 30 70 e
      # Set CPU to run at a minimum of %30 to a maximum of %70 of its capacity, enable Turbo Boost.
```
## Example ss (PoC)
![poc](https://github.com/f4T1H21/IntelTurboBooster/blob/main/src/poc.png)

## Troubleshooting
_You made sure the points in the [Attention](#attention) but still face errors?_
### Error #1: No Intel® Turbo Boost Technology detected on your system!
![err1](https://github.com/f4T1H21/IntelTurboBooster/blob/main/src/err1.png)

__Possible Reason__ : That's because either your CPU does not support intel_pstate driver, which means you are not able to boost your CPU with this tool.

__Reason #2:__ Or you have it but some of the following files which should be in `/sys/devices/system/cpu/intel_pstate/` directory are missing.
- `min_perf_pct`
- `max_perf_pct`
- `no_turbo`

__Solution #2:__
Create missing files as root. 

### Error #2: Failed to enable Turbo Boost, operation not permitted!
![err2](https://github.com/f4T1H21/IntelTurboBooster/blob/main/src/err2.png)

__Reason:__ This is the error when your hardware is NOT able to run Turbo Boost anymore. That's because of your hardware's insufficient performance and mostly temporary. Also you can still change your CPU's clock speed but if you don't enable Turbo Boost, even you set 100 to maximum, CPU will run at its base clock speed. 

__Solution:__ You can fix it by charging your laptop and kinds like this if it is temporary for you. But if your hardware can not even permorn enabling Turbo Boost once, then I don't think you have a solution other than using a higher performance CPU.

---

Constructive feedback is appreciated,<br>
Thank you for your interest.<br><br>
___- Written by f4T1H -___
