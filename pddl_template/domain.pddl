(define (domain UpdsideDown)

    (:requirements
        :typing
        :negative-preconditions
        :conditional-effects
    )

    (:types
        matches keys - items
        cells
        colour
    )

    (:predicates
        
        ;Indicates the number of uses left in a key
        (key-infinite-uses ?k - keys)

        (key-two-use ?k - keys)
        
        (key-one-use ?k - keys)
        
        (key-used-up ?k - keys)

        ;Add other predicates needed to model this domain 
       
        
    )

    ;Hero can move if the
    ;    - hero is at current location
    ;    - cells are connected, 
    ;    - there is no monster in current loc and destination, and 
    ;    - destination is not invigilated
    ;Effects move the hero, and the original cell becomes invigilated.
    (:action move
        :parameters (?from ?to - cells)
        :precondition (and 
                            
                            
        )
        :effect (and 
                            
                )
    )
    
    ;When this action is executed, the hero leaves a location with a monster in it
    (:action move-out-of-monster
        :parameters (?from ?to - cells)
        :precondition (and 
                            
        )
        :effect (and 
                            
                )
    )

    ;When this action is executed, the hero leaves a location without a monster and gets into a location with a monster
    (:action move-into-monster
        :parameters (?from ?to - cells ?m - matches)
        :precondition (and 
                            
        )
        :effect (and 
                            
                )
    )
    
    ;Hero's picks a key if he's in the same location
    (:action pick-key
        :parameters (?loc - cells ?k - keys)
        :precondition (and 
                            
                      )
        :effect (and
                            
                )
    )

    ;Hero's picks a match if he's in the same location
    (:action pick-match
        :parameters (?loc - cells ?m - matches)
        :precondition (and 
                            
                      )
        :effect (and
                            
                )
    )
    
   ;Hero's drops his key. 
    (:action drop-key
        :parameters (?loc - cells ?k - keys)
        :precondition (and 
                            
                      )
        :effect (and
                            
                )
    )

    ;Hero's drops his match. 
    (:action drop-match
        :parameters (?loc - cells ?m - matches)
        :precondition (and 
                            
                      )
        :effect (and
                            
                )
    )
    
    ;Hero's disarm the trap with his hand
    (:action close-gate
        :parameters (?from ?to - cells ?k - keys ?c - colour)
        :precondition (and 
                            
                      )
        :effect (and

                    ;When a key has two uses, then it becomes a single use
                    (when (key-two-use ?k) (key-one-use ?k))
                    ;When a key has a single use, it becomes used-up
                    (when (key-one-use ?k) (key-used-up ?k))       
                )
    )

    ;Hero strikes her match
    (:action strike-match
        :parameters (?m - matches)
        :precondition (and 
                            
        )
        :effect (and 
                           
        )
    )
    
)