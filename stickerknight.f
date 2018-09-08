empty
0 0 0 include ramen/cutlet.f

include ramen/tiled/tiled.f
include ramen/lib/stage.f

#1 to #globalscale
nativewh resolution
stage 1000 pool: layer0

\ ------------------------------------------------------------------------------------------------
\ Load map

only forth definitions also xmling also tmxing
: loadmap 
0 tmxtileset dup load-tiled-bitmaps
                 load-tiled-recipes

s" stickerknight/data/sandbox.tmx" loadmap


:is tmxobj ( object-nnn XT -- )  over ?type if cr type then  execute ;
:is tmxrect ( object-nnn w h -- )  .s 3drop ;
:is tmximage ( object-nnn gid -- )
    layer0 one  gid !  drop
    draw>  @gidbmp blit ;

s" parallax" find-objgroup load-objects
s" game" find-objgroup load-objects
s" bounds" find-objgroup load-objects
\ ------------------------------------------------------------------------------------------------

warm go


