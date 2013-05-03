(define projectile%
  
  (class item%
    (super-new)
    
    (init-field start-velocity
                projectile-size
                slow-down
                destroy-on-impact
                stationary-item)
    
    
    
    (field (decimal-velocity (mcons (* 1.0 (mcar start-velocity)) (* 1.0 (mcdr start-velocity)))))
    
    (inherit get-future-position
             delete!)
    
    (inherit-field velocity
                   size
                   position
                   zero-velocity)
    
    (set! velocity start-velocity)
    (set! size projectile-size)
    
    (define/public (destroy-on-impact?) destroy-on-impact)
    
    (define/private (pixel-to-tile pixel-position)
      (mcons
       (quotient (mcdr pixel-position) 32)
       (quotient (mcar pixel-position) 32)))
    
    
    (define/public (bounce!)
      (if (= (mcar (pixel-to-tile position)) (mcar (pixel-to-tile (get-future-position 8))))
          (begin (set-mcar! velocity (- (mcar velocity)))
                 (set-mcar! decimal-velocity (- (mcar decimal-velocity))))
          (begin (set-mcdr! velocity (- (mcdr velocity)))
                 (set-mcdr! decimal-velocity (- (mcdr decimal-velocity))))))
     
    (define/private (get-velocity-vector)
      (sqrt (+ (expt (mcar velocity) 2) (expt (mcdr velocity) 2))))
    
    (define/override (move!)
      (super move!)
      (unless (not (and (not (equal? velocity zero-velocity)) slow-down))
        (if (and (< (abs (mcdr decimal-velocity)) 2) (< (abs (mcar decimal-velocity)) 2))
            (begin (set-mcar! decimal-velocity 0)
                   (set-mcdr! decimal-velocity 0)
                   (send *level* add-game-object! stationary-item)
                   (send stationary-item set-position! position)
                   (send stationary-item set-current-agent! #f)                   
                   (delete!))
            (begin (set-mcar! decimal-velocity (* 0.96 (mcar decimal-velocity)))
                   (set-mcdr! decimal-velocity (* 0.96 (mcdr decimal-velocity)))))
        (set-mcar! velocity (round (mcar decimal-velocity)))
        (set-mcdr! velocity (round (mcdr decimal-velocity)))))))
      