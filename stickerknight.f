0 0 0 include ramen/ramen.f
require ramen/cutlet.f
require ramen/lib/cam.f

#1 to #globalscale
1024 768 resolution
stage 1000 pool: layer0

var flip

also tmxing also xmling
: !wh
    dup gid@ tilebmp 0= if drop exit then
    dup wh@ rot  gid@ tilebmp bmpwh 2/ sx 2! ;
: !flip  flip@ flip ! ;
: !ang   dup s" rotation" attr? if  rotation@ ang !  else drop then ;

:is tmxobj ( object-nnn XT -- )  over obj?type if cr type then  execute ;
:is tmxrect ( object-nnn w h -- )  .s 3drop ;
:is tmximage ( object-nnn gid -- )
    \ dup tilebmp bmpwh -0.5 -0.5 2* +at
    layer0 one
    gid !  ( nnn )
    dup !wh  dup !ang  !flip  
    draw>  untinted  @gidbmp sx 2@ ang @ >rad flip @ srblitf ;
previous previous
    
: load
    s" stickerknight/data/sandbox.tmx" open-map
    0 load-bitmaps  0 load-recipes
    #objgroups for  i objgroup load-objects  loop
;

load warm
