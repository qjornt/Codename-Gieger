(define item%
  
  (class game-object%
    
    (field (current-agent #f))
    
    ;Current agent methods
    (define/public (get-current-agent) current-agent)
    (define/public (set-current-agent! new-agent)
      (set! current-agent new-agent))
    
    (super-new)))