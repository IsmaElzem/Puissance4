AFFCAR:
    MOVE #6,D0
    TRAP #15
    RTS

SAISCAR:
    MOVE #5,D0
    TRAP #15
    RTS

FINPRG:
    MOVE #9,D0
    TRAP #15
    
    
SET_PEN_COLOR:
    MOVE #80,D0
    TRAP #15
    RTS
    
SET_FILL_COLOR:
    MOVE #81,D0
    TRAP #15
    RTS
 
DRAW_FILL_RECT
    MOVE #87,D0
    TRAP #15
    RTS   
   
DRAW_FILL_ELLIPSE
    MOVE #88,D0
    TRAP #15
    RTS
    
DRAW_STRING
    MOVE #95,D0
    TRAP #15
    RTS

KEYBOARD_ECHO
    MOVE #12,D0
    TRAP #15
    RTS

WIDTH_PEN
    MOVE #93,D0
    TRAP #15
    RTS

LOAD_SOUND
    MOVE #71,D0
    TRAP #15
    RTS
    
PLAY_SOUND
    MOVE #76,D0
    TRAP #15
    RTS
