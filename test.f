s" data/test.png" image: test.png

require ramen/lib/draw
: test  show>  black backdrop
    test.png >bmp
    1 1 1 1 4af
    0 0 0 0 4af
    0.25 0.25 0 3af
    0 al_draw_tinted_scaled_rotated_bitmap ;
    
