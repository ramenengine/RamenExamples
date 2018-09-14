empty
0 0 0 include ramen/ramen.f
require ramen/cutlet.f
require ramen/lib/cam.f

#1 to #globalscale
1024 768 resolution
stage 1000 pool: layer0

:is tmxobj ( object-nnn XT -- )  over ?type if cr type then  execute ;
:is tmxrect ( object-nnn w h -- )  .s 3drop ;
:is tmximage ( object-nnn gid -- )
    0 -200 +at  layer0 one  gid !  drop
    draw>  @gidbmp blit ;
    
: load
    s" stickerknight/data/sandbox.tmx" open-map
    0 load-bitmaps  0 load-recipes
    #objgroups for  i objgroup load-objects  loop
;

load warm
