DRAWELLIPSE:
*'DRAWELLIPSE' permet de 'dessiner' l'ellipse dans la case choisie   
    MOVE.W D5,D1 *X1 ; D5 contient X1
    MULU.W #50,D1
    ADD.W #52,D1
   
    MOVE.W D1,D3 *X2 ; D1 contient X2
    ADD.W #45,D3
   
    MOVE.W D6,D2 *Y1 ; D6 contient Y1 
    MULU #50,D2
    ADD.W #52,D2
   
    MOVE.W D2,D4 *Y2 ; D2 contient Y2
    ADD.W #45,D4
   
    JSR DRAW_FILL_ELLIPSE
 





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
