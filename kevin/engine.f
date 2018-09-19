require ramen/cutlet.f

var looped
:is animlooped   looped on ;
: end-of-anm?  looped @  looped off ;
: animthru   animate  begin  pause  end-of-anm? until ;
