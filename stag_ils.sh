#!/bin/bash

##
# v0.1a - demo/POC code:
#ls -l --color ./exampleDir | stag_ils;                     # ls -l replacement
#ls --color ./exampleDir | stag_ils;                        # ls -1 replacement
#ls -Cw $(($COLUMNS - 4)) --color exampleDir/ | stag_ils;   # ls replacement
#ls -Cw $(($COLUMNS - 4)) --color | stag_ils;               # real-world usage: list the files used to build this POC ! :P
#echo
#
#stag__lscolors | stag_ils
##


# stag_ils.sh - add glyph icons for the supported types to ls output
#
# TODO: add the necessary override to ~/.bashrc & cie
# ex: LS_COLORS=$LS_COLORS:'*.tef=38;5;208:' export LS_COLORS
#     /!\ correct syntax for me: LS_COLORS=$LS_COLORS'*.tef=38;5;208:'; export LS_COLORS
#                                LS_COLORS=$LS_COLORS'*.txt=38;5;249:'; export LS_COLORS
#
# /!\ NECESSARY FIX FOR THE COLUMNS NOT TO BE MESSED UP: LS_COLORS='*=0;0:'$LS_COLORS; ; export LS_COLORS
#
# -- full override(s) --
# => in their own file, see 'LS_COLORS_overrides' -> to be sourced when calling the script on in ~/.bashrc
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
  #output="${output//[0;0m/000;0m}"
  output="${output//[0;0m/[0;0m'   '}"
  # rs ( reset to ordinary colors ) - 'll need an override .. but it's the one used to reset stuff .., so I don't know what happens on override .. also, it's the same that closes the stuff
  # idea of fix: override only instance that are followed by some text - aka , '0m<different-than-empty'
  #output="${output//0m /0m'   END'}"
  # hacky fix - since I can't figure out the simple way to get '0m not followed by a space', replace it ONCE
  #output="${output//0m /TEFFIX}"
  #output="${output//;0m/TEFKIP}"
  #output="${output//0m/TEFKIP}"
  #output="${output//0m^ /0m'BEGINNING   '}" # doesn't work as 'not a space'
  #output="${output//0m*./0m'BEGINNIG   '}"
  # echo "${myString//0[a-zA-Z.][^ ]/123}" - WIP troubleshooting :|
  # hacky fix - replace it twice, back
  #output="${output//TEFKIP/;0m}"
  #output="${output//TEFFIX/0m }"
  #output="${output//TEFKIP/0m}"
  #output="${output//0m/0m'   123'}"
  # di ( dirs )
  output="${output//01;34m/01;34m'   '}"
  # mh ( ? )
  #output="${output//00m/00m'   '}"
  output="${output//00m/00m}"
  # ln ( symbolic link )
  # pi ( fifo file )
  output="${output//40;33m/40;33m\\xE2\\xA7\\x91  }"
  # so ( socket file )
  # do ( door )
  # bd ( block ( buffered ) special file )
  # cd ( character ( unbuffered ) special file
  # or ( symbolic link pointing to a non-existent file (orphan) )
  # su ( setuid )
  # sg ( setgid )
  # ca ( ? )
  # tw ( ow w/ sticky )
  # ow ( ow w/ sticky )
  # st ( sticky )
  # ex ( executable )
  # -- colored icons --
  #text         -->    ✎     --> \xE2\x9C\x8E
  output="${output//38;5;249m/38;5;249m\\xE2\\x9C\\x8E  }"
  #code         -->    ⚛     --> \xE2\x9A\x9B
  #code 2       -->    ⚝       --> \xE2\x9A\x9D
  #invoices     -->    €    --> \xE2\x82\xAC
  #image        -->    ✿     --> \xE2\x9C\xBF
  output="${output//38;5;161m/38;5;161m\\xE2\\x9C\\xBF  }"
  #video        -->    ▶     --> \xE2\x96\xB6
  output="${output//38;5;97m/38;5;97m\\xE2\\x96\\xB6  }"
  #audio        -->    ♪      --> \xE2\x99\xAA
  output="${output//00;36m/00;36m\\xE2\\x99\\xAA  }"
  #bookmark     -->    ★     --> \xE2\x98\x85
  #daemon       -->    ⌚        --> \xE2\x8C\x9A
  #script       -->    ⚡      --> \xE2\x9A\xA1
  output="${output//01;32m/01;32m\\xE2\\x9A\\xA1  }"
  #archive      -->    ♊     --> \xE2\x99\x8A
  output="${output//01;31m/01;31m\\xE2\\x99\\x8A  }"
  #pipe         -->    ⧑     --> \xE2\xA7\x91
  # see 'pi' above
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
