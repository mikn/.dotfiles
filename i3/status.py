# vim: set fileencoding=utf-8 :
from i3pystatus import Status

status = Status(standalone=True)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock", format="%a %-d %b %X KW%V",)
status.register("clock", format=("SE %X", "Europe/Stockholm"),)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load")

status.register("shell",
                command="xkblayout-state print 'KB: %s'| awk '{print toupper($0)}'",
                on_leftclick="xkblayout-state set +1"
)

# Shows your CPU temperature, if you have a Intel CPU
# status.register("temp", format="{temp:.0f}°C",)

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via D-Bus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
# If you don't have a desktop notification demon yet, take a look at dunst:
#   http://www.knopwob.org/dunst/
status.register(
    "battery",
    format="{status}/{consumption:.2f}W {percentage:.0f}%"
           " [{remaining:%E%hh:%Mm}]",
    alert=True,
    full_color="#538947",
    charging_color="#538947",
    critical_color="#AB4642",
    alert_percentage=7,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)

# Shows the address and up/down state of eth0. If it is up the address is
# shown in green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
status.register("network",
                ignore_interfaces=['wlp2s0', 'lo'],
                color_up="#538947",
                format_up="{interface}: {v4cidr}",
                format_down="")

# Note: requires both netifaces and basiciw (for essid and quality)
status.register("network",
                interface="wlp2s0",
                color_up="#538947",
                format_up="{v4cidr} {essid:.16} {quality}%",)

# Shows disk usage of /
# Format:
# 42/128G [86G]
status.register("disk",
                path="/",
                format="{avail}/{total}G",)

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio", format="♪{volume}",)

status.register("backlight", backlight="intel_backlight")

status.register("spotify", format="{status} {artist} - {title}")

status.run()
