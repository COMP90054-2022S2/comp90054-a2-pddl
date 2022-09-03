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
        (heroAt ?a - cells)
        (connected ?a ?t - cells)
        (monster ?loc - cells)
        (visited ?loc - cells)
        (useMatches)
        (haveMatches ?m - matches)
        (haveKeys ?k - keys)
        (keyLoc ?loc - cells ?k - keys)
        (emptyHand)        
        (matches ?loc - cells ?m - matches)
        (keysC ?k - keys ?c - colour)
        (lockDoor ?c - colour ?loc - cells)
        (openDoor ?c - colour ?loc - cells)
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
        (heroAt ?from)
        (connected ?from ?to)
        (not (monster ?from))
        (not (visited ?to))
        )
        :effect (and 
            (heroAt ?to)
            (visited ?from)
            (not (heroAt ?from))
            (not (useMatches))
            
        )
    )
    
    ;When this action is executed, the hero leaves a location with a monster in it
    (:action move-out-of-monster
        :parameters (?from ?to - cells)
        :precondition (and 
        (heroAt ?from)
        (monster ?from)
        (useMatches)
        (connected ?from ?to)
        (not (visited ?to))
        )
        :effect (and 
        (not (heroAt ?from))
        (heroAt ?to)
        (visited ?from)
        (not (useMatches))
            
        )
    )

    ;When this action is executed, the hero leaves a location without a monster and gets into a location with a monster
    (:action move-into-monster
        :parameters (?from ?to - cells ?m - matches)
        :precondition (and 
        (heroAt ?from)
        (monster ?to)
        (not (visited ?to))
        (connected ?from ?to)
        (haveMatches ?m)
            
        )
        :effect (and 
            (heroAt ?to)
            (not (heroAt ?from))
            (visited ?from)
            (not (useMatches))
                    )
    )
    
    ;Hero's picks a key if he's in the same location
    (:action pick-key
        :parameters (?loc - cells ?k - keys)
        :precondition (and 
            (emptyHand)
            (heroAt ?loc)
            (keyLoc ?loc ?k)
                      )
        :effect (and
            (not (emptyHand))
            (haveKeys ?k)
            (not (keyLoc ?loc ?k))
                )
    )

    ;Hero's picks a match if he's in the same location
    (:action pick-match
        :parameters (?loc - cells ?m - matches)
        :precondition (and 
        (emptyHand)
        (heroAt ?loc)
        (matches ?loc ?m)
                    )
        :effect (and
            (not (emptyHand))
            (not (matches ?loc ?m))
            (haveMatches ?m)
                 )
    )
    
   ;Hero's drops his key. 
    (:action drop-key
        :parameters (?loc - cells ?k - keys)
        :precondition (and
            (heroAt ?loc)
            (haveKeys ?k)
            (not(emptyHand))
        )
        :effect (and 
            (emptyHand)
            (keyLoc ?loc ?k)
            (not (haveKeys ?k))
                    )
    )

    ;Hero's drops his match. 
    (:action drop-match
        :parameters (?loc - cells ?m - matches)
        :precondition (and
            (heroAt ?loc)
            (haveMatches ?m)
            (not(emptyHand))
        )
        :effect (and 
        (emptyHand)
        (matches ?loc ?m)
        (not (haveMatches ?m))
        )
    )
    
    ;Hero's disarm the trap with his hand
    (:action close-gate
        :parameters (?from ?to - cells ?k - keys ?c - colour)
        :precondition (and 
        (heroAt ?from)
        (connected ?from ?to)
        (haveKeys ?k)
        (keysC ?k ?c)
        (openDoor ?c ?to)
        
        (or
            (key-infinite-uses ?k)
            (key-two-use ?k)
            (key-one-use ?k)
            
                      ))
        :effect (and
        (not (openDoor ?c ?to))
        (lockDoor ?c ?to)
        
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
            (haveMatches ?m)
            (not(useMatches))
        )
        :effect (and 
        (useMatches)
        
        )
    )
    
)
;testing push