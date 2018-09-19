require kevin/engine.f

s" kevin/data/chr_lk.png" image: kevin.image 
kevin.image 20 20 subdivide
0 kevin.image 0.25
    3dup anim: idle-anim    kevin.image , 0  , ;anim
    3dup anim: duck-anim    kevin.image , 10 , ;anim
    3dup anim: blink-anim   kevin.image , 11 , 12 , ;anim
    3dup anim: walk-anim    kevin.image , 29 , 30 , 31 , ;anim
    3dup anim: jump-anim    kevin.image , 36 , ;anim
3drop

create  dirs  FLIP_NONE , FLIP_NONE , FLIP_NONE , FLIP_H ,
: flip@  dirs dir @ [] @ ;

var dir    \ direction, see above enums
var data   \ static NPC data, like animation pointers
rolevar walkspeed   
rolevar jumppower
rolevar risepower
var inair
var falling
<space> constant <jump>
<down> constant <squat>
action walkl 
action walkr 
action jump  
action squat 
action fall  
action idle  
action die   
action land  

: in-air?  inair @ ;
: faceleft  DIR_LEFT dir ! ;
: faceright  DIR_RIGHT dir ! ;
: can-jump   vy @ 0> ?exit  <jump> kpressed if jump then ;
: can-walk   <left> kstate if walkL then   <right> kstate if walkR then ;
: can-squat   <squat> kstate if squat then ;
: can-die ;
: control-in-air
   <left> kstate if  -0.2 vx +!  faceleft then
   <right> kstate if  0.2 vx +!  faceright then
   vx @ 0.95 *  walkspeed @ vx @ 0< if negate max else min then vx ! ;
: drift   vx @ 0.90 * vx !   ;
: movelegs   ( n. - )  abs 5.0 swap -   anmspd ! ;
: to-a-stop
    drift
    vx @ abs 0.2 <
        if   0 vx !   idle-anim 
        else  vx @ movelegs  then ;
: walkAccelR   vx @ 0.14 + walkSpeed @ min dup vx ! movelegs ;
: walkAccelL   vx @ 0.14 - walkSpeed @ negate max dup vx ! movelegs ;
: (fall)   inair on  falling @ not  vy @ 0 >= and  if  falling on  fall  then ;
: (land)   falling off  inair off  land  ;
: hitmap  floor? not if  (fall)  else  in-air? if  (land)  then  then ;
: gravity  0.15 vy +! ;
: conf
    3 1 mbx 2!
    14 19 mbw 2!
    act>  gravity
    onhitmap>  drop  hitmap ;

roledef kevin
1.6 kevin 's walkspeed !
2.75 kevin 's jumppower !
0.1022 kevin 's risepower !
kevin :to fall  (fall)  0 perform>  jump-anim  begin control-in-air pause again ;
kevin :to land  idle ;
kevin :to jump
   0 perform>   jump-anim  jumppower @ negate vy !
   risepower @ negate
   begin   vy @ 0<  <jump> kstate  and
   while   dup vy +!  control-in-air   pause   repeat
   fall ;
kevin :to walkl
   0 perform>  faceleft  walk-anim 1 animate
   begin <left> kstate in-air? not and  while
        walkAccelL can-squat can-jump can-die   pause  repeat
   idle ;
kevin :to walkr
   0 perform>  faceright  walk-anim 1 animate
   begin <right> kstate in-air? not and  while
        walkAccelR can-squat can-jump can-die   pause   repeat
   idle ;
kevin :to idle
    0 perform> ?walk-anim
    begin  to-a-stop  can-walk  can-squat  can-die  can-jump  pause   again ;

: /kevin  kevin role !  fall  conf ;
