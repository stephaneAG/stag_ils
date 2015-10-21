#!/bin/bash

# stag_ils.sh - add glyph icons for the supported types to ls output
#
# TODO: add the necessary override to ~/.bashrc & cie
# ex: LS_COLORS=$LS_COLORS:'*.tef=38;5;208:' export LS_COLORS
#     /!\ correct syntax for me: LS_COLORS=$LS_COLORS'*.tef=38;5;208:'
#
# /!\ NECESSARY FIX FOR THE COLUMNS NOT TO BE MESSED UP: LS_COLORS='*=0;0:'$LS_COLORS 
#
# LATEST COMBO TEST-POC:
# stag__lscolors | stag_ils; ls -Cw $(($COLUMNS -10)) --color ./.. | stag_ils
#
# combo one-line POC :D => the following line prints icons mapped to their corresponding style rule 
# stag__lscolors | stag_ils
#
# one liner POC
# ls -Cw $(($COLUMNS -10)) --color ./.. | { output=$(while read line; do echo "$line"; done; ); echo -e "${output//32m/32m\\xE2\\x9A\\xA1 }"; }
# .. & as I'm also writing an few helper, let's "combine the characters" ( 2 reading levels ;D ) - R: 'stag__lscolors' pretty-prints the $LS_COLORS content
# stag__lscolors | { output=$(while read line; do echo "$line"; done; ); echo -e "${output//32m/32m\\xE2\\x9A\\xA1 }"; }
#
#
# ls -Cw $(($COLUMNS -10)) --color ./.. > dummyDataLS_keepColumnsMinus10AndColor.txt
# myData=$(cat dummyDataLS_keepColumnsMinus10AndColor.txt)
#
# ORIGINAL OUTPUT:
# echo -e "${myData}"
# COLOR-CHANGED OUTPUT:
# echo -e "${myData//34m/35m}"

# COLORED ICONS FOR SOME FILETYPE ( use the color of the filetype to deduce the right icon - aka, custom .extension(s) have to be registered, but it works OS-wide ;P )
# to "register" colors for custom extensions see -> http://askubuntu.com/questions/466198/how-do-i-change-the-color-for-directories-with-ls-in-the-console
# - scripts -
# echo -e "${myData//01;32m/01;32m\\xE2\\x9A\\xA1 }"
# - images -
# echo -e "${myData//01;35m/01;35m\\xE2\\x9C\\xBF }"
# ( .. )

# UNCOLORED ICON FOR SOME FILETYPE ( still deduces the icon to be used depending on the filetype )
# - scripts -
# echo -e "${myData//01;32m/0m\\xE2\\x9A\\xA1 \\e\[01;32m}"
# ( .. )


stag_ils(){
  # get the output to iconify using the rules from $LS_COLORS
  output=$(while read line; do echo "$line"; done; );
  # TODO: - if '-c' parameter is passed, we don't use colors for the icons, otherwise we do, by default
  #       - thnk about other different 'sets' of icons to be appended: filetypes ( current: img, script, .. )| rights ( 0755, .. ) | owner ( chown ..) | last edit/creation ( minute, hour, day, month, year, .. )
  #       BUT! -> implementing the idea in the above line would require much work, with some parsing NOT based on colors ;) 
  #
  # -- 3px fix for no-icon-ed stuff ( ex: dirs ) --
  # everything ( * wildcard & specific 0;0, not used by the system ) - used to backspace
  #output="${output//0;0m/0;0m'   '}"
  #output="${output//0;0m/0;0m'\b\b\b'}"
  output="${output//0;0m/0;0m}"
  # rs ( reset to ordinary colors )
  output="${output//0m/0m'   '}"
  # di ( dirs )
  output="${output//01;34m/01;34m'   '}"
  # mh ( ? )
  #output="${output//00m/00m'   '}"
  output="${output//00m/00m}"
  # ln
  # pi
  # so
  # do
  # bd
  # cd
  # or
  # su
  # sg
  # ca
  # tw
  # ow
  # st
  # -- colored icons --
  #text         -->    ✎     --> \xE2\x9C\x8E
  #code         -->    ⚛     --> \xE2\x9A\x9B
  #code 2       -->    ⚝       --> \xE2\x9A\x9D
  #invoices     -->    €    --> \xE2\x82\xAC
  #image        -->    ✿     --> \xE2\x9C\xBF
  output="${output//01;35m/01;35m\\xE2\\x9C\\xBF  }"
  #video        -->    ►     --> \xE2\x96\xBA
  #audio        -->    ♪      --> \xE2\x99\xAA
  output="${output//00;36m/00;36m\\xE2\\x99\\xAA  }"
  #bookmark     -->    ★     --> \xE2\x98\x85
  #daemon       -->    ⌚        --> \xE2\x8C\x9A
  #script       -->    ⚡      --> \xE2\x9A\xA1
  output="${output//01;32m/01;32m\\xE2\\x9A\\xA1  }"
  #archive      -->    ♊     --> \xE2\x99\x8A
  output="${output//01;31m/01;31m\\xE2\\x99\\x8A  }"
  #flag         -->    ⚑     --> \xE2\x9A\x91
  #tef          -->    ⌬     --> \xE2\x8C\xAC
  output="${output//38;5;208m/38;5;208m\\xE2\\x8C\\xAC  }"
  #tefinfo      -->    ⏣     --> \xE2\x8F\xA3

  # -- uncolored icons --
  
  # fix for the 3px offset at the beginning
  echo -e -n "\b\b\b"
  # iconized output
  echo -e "${output}";
  #echo -e "\b\b\b${output}";
}
