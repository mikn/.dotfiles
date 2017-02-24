#!/bin/sh
# Base16 Oceanic Next - Virtual console color setup script
# Dmitri Voronianski (http://pixelhunter.me)

color00="1B2B34" # Base 00 - Black
color01="EC5f67" # Base 08 - Red
color02="99C794" # Base 0B - Green
color03="FAC863" # Base 0A - Yellow
color04="6699CC" # Base 0D - Blue
color05="C594C5" # Base 0E - Magenta
color06="5FB3B3" # Base 0C - Cyan
color07="C0C5CE" # Base 05 - White
color08="65737E" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="D8DEE9" # Base 07 - Bright White

# 16 color space
echo -en "\e]P0$color00"
echo -en "\e]P1$color01"
echo -en "\e]P2$color02"
echo -en "\e]P3$color03"
echo -en "\e]P4$color04"
echo -en "\e]P5$color05"
echo -en "\e]P6$color06"
echo -en "\e]P7$color07"
echo -en "\e]P8$color08"
echo -en "\e]P9$color09"
echo -en "\e]PA$color10"
echo -en "\e]PB$color11"
echo -en "\e]PC$color12"
echo -en "\e]PD$color13"
echo -en "\e]PE$color14"
echo -en "\e]PF$color15"
if [ -x /usr/bin/clear ]; then
  /usr/bin/clear
else
  echo -en "\e[H"
  echo -en "\e[2J"
fi

# clean up
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
