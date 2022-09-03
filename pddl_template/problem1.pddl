;It's recommended to install the misc-pddl-generators plugin 
;and then use Network generator to create the graph
(define (problem p1-UpdsideDown)
  (:domain UpdsideDown)
  (:objects
    cell-1 cell-2 cell-3 cell-4 cell-5 cell-6 cell-7 cell-8 cell-9 cell-10 cell-11 - cells
    red green blue - colour
    m1 - matches
    k1 k2 k3 - keys

  )
  (:init
  
    ;Initial Hero Location
    (heroAt cell-1)
    
    ;She starts with a free arm
    (emptyHand)
    
    ;Initial location of the keys
    (keyLoc cell-2 k1)
    (keyLoc cell-8 k2)
    (keyLoc cell-10 k3)    
    ;Initial location of the matches
    (matches cell-4 m1)
    
    ;Initial location of Monsters
    (monster cell-3)
    
    ;Initial lcocation of open gates
    (openDoor red cell-5)
    (openDoor green cell-6)
    (openDoor green cell-9)
    (openDoor blue cell-7)
    

    ;Key uses
    (key-infinite-uses k1)
    (key-one-use k3)
    (key-two-use k2)
    
    ;Key Colours
    (keysC k1 red)
    (keysC k2 green)
    (keysC k3 blue)
    ;Graph Connectivity
    
    (connected cell-1 cell-2)
    (connected cell-2 cell-1)
    (connected cell-2 cell-3)
    (connected cell-2 cell-3)
    (connected cell-2 cell-5)
    (connected cell-5 cell-2)
    (connected cell-3 cell-4)
    (connected cell-4 cell-3)
    (connected cell-3 cell-6)
    (connected cell-6 cell-3)
    (connected cell-3 cell-11)
    (connected cell-4 cell-7)
    (connected cell-7 cell-4)
    (connected cell-5 cell-6)
    (connected cell-5 cell-8)
    (connected cell-8 cell-5)
    (connected cell-6 cell-7)
    (connected cell-6 cell-9)
    (connected cell-7 cell-10)
    (connected cell-8 cell-9)
    (connected cell-9 cell-10)
    (connected cell-9 cell-6)
    (connected cell-10 cell-7)


    
  )
  (:goal (and
    ;Hero's Goal Location
    (heroAt cell-11)
    
    ;All gates are closed
    (lockDoor red cell-5)
    (lockDoor green cell-6)
    (lockDoor blue cell-7)
    (lockDoor green cell-9)
    
  ))
  
)