0 0 0 include ramen/ramen.f
require ramen/cutlet.f
require ramen/lib/cam.f

s" island/data/islandz.tmx" open-map

0 load-tmxtileset
s" Ground" find-tmxlayer  tilebuf 0 0 load-tmxlayer

: -act  act> noop ;
cam as  -act

create tm object  /tilemap  128 64 x 2!  128 128 w 2!

\ scroll the tilemap
: bounce  1 1 vx 2!  act>
    vx @ 0< if  x @ 0 < if  vx @ negate vx !  then then
    vy @ 0< if  y @ 0 < if  vy @ negate vy !  then then
    vx @ 0> if  x @ 600 >= if  vx @ negate vx !  then then
    vy @ 0> if  y @ 450 >= if  vy @ negate vy !  then then
    vx 2@ tm 's scrollx 2+! ;

stage object: scroller  10 15 x 2!  bounce

: (show)  show>  black backdrop  tm >{ draw }   subject track  camtrans  stage drawzsorted ;
:is warm  (show)  ;

warm
