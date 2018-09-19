\ Platforming example
#1 0 0 include ramen/ramen.f
require ramen/cutlet.f
include kevin/kevin.f
320 240 resolution
0 0 at 
stage object: bg1   /tilemap   320 240 w 2!
stage object: p1    /kevin

: scrollxy  p1 's x 2@   160 120 2-  0 0 2max ;
: movecam  scrollxy mytm scroll-tilemap ;
transform m0
: scroll>  m0 al_identity_transform  m0 scrollxy 2negate 2af al_translate_transform  m0 al_use_transform  r> call  1-1 ;

\  Main loop configuration; COLLIDE-OBJECTS-MAP enables tilemap collisions in conjunction with HITMAP> (see kevin.f)
\ :noname [ is prerender ]  grey backdrop  framebuf onto  black backdrop ;
\ :noname [ is render ]     movecam        framebuf onto  1-1 bg1 draw-objlist  scroll>  objects draw-objlist ;
\ :noname [ is postrender ] displayw 320 3 * - 0 at  white  framebuf dup bmpwh 3 3 2* sblit ;
\ :noname [ is poststep ]   eachlist> 20 collide-objects-map ;
\ 
\ interact off  \ start without IDE visible
