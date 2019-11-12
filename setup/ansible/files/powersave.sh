#! /bin/sh

sysctl_powersave="vm.dirty_writeback_centisecs=1500 vm.laptop_mode=5 kernel.nmi_watchdog=0"
sysctl_ac_power="vm.dirty_writeback_centisecs=500 vm.laptop_mode=0 kernel.nmi_watchdog=1"
sysctl_vars="vm.dirty_writeback_centisecs vm.laptop_mode kernel.nmi_watchdog"

cpu_performance="balance_performance"
cpu_powersave="balance_power"

case $1 in
    true )  sysctl_settings=$sysctl_powersave
            cpu_powerstate=$cpu_powersave
            iw_powersave="on"
            pcie_aspm_policy="powersupersave"
            ;;
    false ) sysctl_settings=$sysctl_ac_power
            cpu_powerstate=$cpu_performance
            iw_powersave="off"
            pcie_aspm_policy="performance"
            ;;
    auto )
            if [ $(cat /sys/class/power_supply/AC/online) = '0' ]; then
                $0 true
                exit
            else
                $0 false
                exit
            fi
            ;;

    * )     /sbin/sysctl $sysctl_vars
            exit 0
            ;;
esac

for iface in $(ls /sys/class/net/ | grep -P "^wl.+"); do
    /sbin/iw dev $iface set power_save $iw_powersave
done

/sbin/sysctl -w $sysctl_settings

# change powersave setting on audio card
echo -n 1 > /sys/module/snd_hda_intel/parameters/power_save

echo -n $pcie_aspm_policy > /sys/module/pcie_aspm/parameters/policy

for pci_dev in $(ls /sys/class/pci_bus/); do
    if [ -f "/sys/class/pci_bus/$pci_dev/power/control" ]; then
        echo -n "auto" > /sys/class/pci_bus/$pci_dev/power/control
    fi
done

for usb_dev in $(ls /sys/bus/usb/devices/); do
    if [ -f "/sys/bus/usb/devices/$usb_dev/power/control" ]; then
        echo -n "auto" > /sys/bus/usb/devices/$usb_dev/power/control
    fi
done

for cpu in $(ls /sys/devices/system/cpu/cpufreq/ | grep -P "^policy\d+"); do
    echo -n $cpu_powerstate > /sys/devices/system/cpu/cpufreq/$cpu/energy_performance_preference
done
