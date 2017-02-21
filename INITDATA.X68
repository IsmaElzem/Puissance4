INITDATA:
*Dans ce sous programme, on remet a jour les variables qui changent tout au long du programme, afin de pouvoir gérer le fait de rejouer ou non.
    MOVE.B #0,BufferLettre+1 *Nous faisons '+1' car on veut que le 2eme byte soit à 0 (le ',0'), et le premier byte sera écraser par la lettre    
    MOVE.B #NUMJOUEUR1,JOUEURACTUEL
    MOVE.B #'1',Tag_Joueur_Gagner
    MOVE.W #00,TOURJOUER
    MOVE.B #MSG_TYPE_JOUEUR_JOUE,TypeMessageAfficher  

*Boucle qui initialise toutes les cases de 'TAB' à 0  
    MOVE.L #TAB,A1
    MOVE #0,D0
LOOP_TAB_INIT:
    CMP #42,D0
    BEQ END_INIT
    MOVE.B #0,(A1)+ *ça incrément l'adresse de A1 par 1 (Indirect Postincrémenté). '.B' = 1 byte 
    ADD #1,D0
    BRA LOOP_TAB_INIT
END_INIT:
    RTS
*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
