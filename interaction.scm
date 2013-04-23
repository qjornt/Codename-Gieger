(define interaction%
  
  (class object%
    
    ;Keyboard controls
    (define/public (new-key-event key-code)
      (cond       
        ;Movement key-events
        ((eq? key-code #\w) (send *player* set-velocity-y! -3))
        ((eq? key-code #\a) (send *player* set-velocity-x! -3))
        ((eq? key-code #\s) (send *player* set-velocity-y! 3))
        ((eq? key-code #\d) (send *player* set-velocity-x! 3))      
        ;Weapon key-events
        ((eq? key-code #\r) (send *player* firearm-reload))
        ((eq? key-code #\f) (send *player* increase-health! -50))       
        ;Pause menu
        ((eq? key-code 'esc) (send *game-loop* pause))))
    
    (define/public (new-key-release-event key-release)
      (cond 
        ;Movement key-release-events
        ((or (eq? key-release #\w) (eq? key-release #\s)) (send *player* set-velocity-y! 0))
        ((or (eq? key-release #\d) (eq? key-release #\a)) (send *player* set-velocity-x! 0))))
    
    
    ;Mouse controls
    (define/public (new-mouse-event mouse-event)
      ;(display mouse-event)
      (cond
        ;Fire
        ((eq? mouse-event 'left-down) (send *player* item-use))
        ;Throw
        ((eq? mouse-event 'right-down) (send *player* item-throw))))
    
    
    ;Update mouse position
    (define/public (new-mouse-position mouse-position)
      (send *player* set-aim-target! mouse-position))
    
    (super-new)))
