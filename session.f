true constant dev
true constant allegro-debug
0 0 0 include ramen/ramen.f
[in-platform] sf [if]
    include ramen/ide/ide.f
    'source-id @ close-file drop
    s" test.f" file-exists [if]  ld test  [then]
    ide
    cr .( Welcome to Ramen )
    cr
    cr .( To enter fullscreen hit ALT-ENTER. )
    cr
    cr .( You can `ld` any of the following: )
    cr .( depth )
    cr .( island )
    cr .( rectland )
    cr .( flies )
    cr .( stickerknight )
    cr .( kevin )
    cr
    cr .( You can clear this text with `wipe`. )
[then]  