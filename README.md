# stag_ils
<img src="http://stephaneadamgarnier.com/stagIconizedLs/stag_ils_1102015.png" align="" height="" width="" >
#### iconizing the output of ls while supporting $LS_COLORS standards &amp; tweaks
<img src="http://stephaneadamgarnier.com/stagIconizedLs/stag_ils__usesGlyphsAsIcons3.png" height="200" width="207">
<img src="http://stephaneadamgarnier.com/stagIconizedLs/stag_ils__usesGlyphsAsIcons4.png" height="200" width="207">
<img src="http://stephaneadamgarnier.com/stagIconizedLs/stag_ils__usesGlyphsAsIcons1.png" height="200" width="207">
<img src="http://stephaneadamgarnier.com/stagIconizedLs/stag_ils__usesGlyphsAsIcons2.png" height="200" width="207">

#### features
- colorized icons right in the terminal ( can be NOT colored as well, but less handy/stylish ;P )
- uses the $LS_COLORS global var to get its coloring scheme ( standard, easily tweakable to support custom types*)
- use font glyphs as it's icons ( any hex value 'll do, & hexdump is here to help .. and so does 'hexFromGlyph' tool )
- wanna have great icons, sntading out in the terminal & matching those cli tools we love ? install some glyph font ! :D 

#### currently supports
Nb: a wrapper for the below cmds 'll be written .. & 'll get aliased to 'ils' on my system ;p

Nb2: the handling of $COLUMN has to be improved ( .. )
- ls
- ls -l
- ls -1
- ( .. )

* a gnome-terminal [ currently "hack-in-progress"] mod that supports Ctrl+left click ( while running X ) is being written to allow easy routing to custom commands / scripts ( currently on uses notify-send notifications ;p )
