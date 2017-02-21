***************************** Programme Principal (MAIN) *****************************  
    ORG    $2000
***************************** On dessine la grille *****************************  
START:  
    JSR INITDATA
    *Grid draw
    MOVE.L #BLUE,D1
    JSR SET_PEN_COLOR
    MOVE.W #2,D1
    JSR WIDTH_PEN
*On dessine le rectangle qui va tout contenir, afin que je restart soit plus facile � faire
    MOVE.W #025,D1
    MOVE.W D1,D2
    MOVE.W #425,D3
    MOVE.W #460,D4
    JSR DRAW_FILL_RECT    
    MOVE.w #050,D2 
    MOVE.w #100,D4
    MOVE.w #0,D6
BOUCLEGRID:    
    MOVE.w #0,D5 *timer a 0                
    MOVE.w #050,D1        
    MOVE.w #100,D3       
LIGNE:
    JSR DRAW_FILL_RECT
    ADD.w  #050,D1
    ADD.w  #050,D3
    ADD.w #1,D5
    CMP.w #7,D5
    BNE LIGNE
    ADD.w #50,D2
    ADD.w #50,D4
    ADD.w #1,D6
    CMP.w #6,D6
    BNE BOUCLEGRID
          
    MOVE #72,D1 *distance avec la marge gauche
    MOVE #360,D2 *on met les lettres en bas de la derni�re ligne
    MOVE #BufferLettre,A1
    MOVE #COLONNELETTRE,A2
    EOR D5,D5 *D5 = 0 avec EOR ou bien faire 'MOVE #0,D5' 
    
    
*****************************  Debut de l'�criture des charact�res (a z e r t y u)  *****************************


*On a "azertyu" -> on ne peut pas avoir une seule lettre de cette cha�ne avec la valeure finale nulle (,0). Donc on copie lettre par lettre 
*dans le 2eme buffer (BufferLettre), o� nous avons � la fin, la valeure finale nulle   
BoucleAffichageLettre:
    MOVE.B (A2)+,(A1)
    JSR DRAW_STRING
    ADD #50,D1
    ADD #1,D5
    CMP #COLONNETOUCHE_LENGTH,D5
    BNE BoucleAffichageLettre
*On a "azertyu", on peut pas avoir une lettre avec le signe nul � la fin, donc on copie lettre par lettre dans le 2eme buffer (BufferLettre), o� le signe nul est bien pr�sent


***************************** Fin affichage de la grille *****************************

***************************** Fin affichage lettres      *****************************




*****************************  DEBUT MUSIQUE *****************************

    LEA musique,A1
    MOVE #0,D1
    JSR LOAD_SOUND
    MOVE.L #1,D2
    JSR PLAY_SOUND
    
***************************** FIN MUSIQUE *****************************






*****************************         Debut Timer        *****************************

  
*Debut du timer afin de voir s'il y a match nul (si les 42 tours ont �t� jou�s) 
BOUCLE:
    CMP.w #42,TOURJOUER *On compte le nombre de tour jouer, si TOUJOUER = 42 alors match nul
    BEQ FINTANTQUE3
    
    
*****************************         FIN TIMER          *****************************






*****************************         DEBUT SAISCAR      *****************************    

SI:        
        *EOR.B D1,D1 *2 opcode byte ($B3 $01)
        MOVE.B #0,D1 *4 byte opcode $32 $3C $00 $00
        *pcode plus petit = plus rapide
        JSR KEYBOARD_ECHO *Pour ne pas afficher les lettres saisis dans la fen�tre 
        JSR AffichageMessage
        JSR SAISCAR
        MOVE.L  #COLONNELETTRE,A0 *A0 contient #COLONNELETTRE
        EOR     D5,D5       *D5 En faisant ceci, on met D5 � z�ro (0 XOR 0 = 0) 
        

*****************************        FIN SAISCAR       *****************************





***************************** Debut Verification lettre *****************************

KeyToColumnLoop:
        CMP.B   (A0)+,D1    *Ici on compare la lettre de l'utilisateur avec celle qu'il y a dans A0 (azertyu). On incr�mente de 1 � chaque fois qu'on v�rifie une lettre dans A0        
        BEQ     LettreTrouver    *Si on trouve la lettre, alors on va � 'LettreTrouver'
        ADD     #1,D5       *On ajoute '1' � D5 pour aller � la prochaine lettre dans 'azertyu'?
        CMP     #COLONNETOUCHE_LENGTH,D5 *COLUMN... = 7 (car 7 lettres). Si c'est �gal, �a veut donc dire qu'on a v�rifier la lettre de l'utilisateur avec les 7 lettres disponibles dans 'COLONNETOUCHE_LENGTH'. Donc l'utilisateur a rentr� une mauvaise lettre        
        BNE     KeyToColumnLoop *Si COLUM... != 7, alors on v�rifie la prochaine lettre dans A0 (gr�ce � l'Indirect Postincr�ment� de A0)

        MOVE.B #MSG_TYPE_MAUVAISE_TOUCHE,TypeMessageAfficher
        BRA     SI *Lettre non trouv�, on recommence � partir de l'�tiquette 'SI'
 
LettreTrouver:  * D5 contient l'index de colonne (0 to 6)
        JSR CHECKBOX *On appel le sous programme 'CHECKBOX'     
        BRA BOUCLE *On retourne dans l'�tiquette 'BOUCLE'


***************************** Fin v�rification lettre *****************************




*****************************  Debut v�rification match nul *****************************
 
FINTANTQUE3:     
    MOVE.B #MSG_TYPE_MATCH_NUL,TypeMessageAfficher
    JSR AffichageMessage
    BRA HandleRestartGame 

*****************************  Fin v�rification match nul *****************************
 
    INCLUDE 'BIBLIO.X68'
    INCLUDE 'CHECKBOX.X68'
    INCLUDE 'DRAWELLIPSE.X68'
    INCLUDE 'TESTFORWINNER.X68'
    INCLUDE 'AFFICHAGEMESSAGE.X68'
    INCLUDE 'INITDATA.X68'
    INCLUDE 'HANDLERESTARTGAME.X68'
    

NUMJOUEUR1 EQU 1 *La valeure de NUMJOUEUR va toujours �tre �gale � 1
NUMJOUEUR2 EQU 2
TEXT_MSG_X EQU 163
TEXT_MSG_Y EQU 403
MSG_TYPE_TURN EQU 0
MSG_TYPE_MAUVAISE_TOUCHE EQU 1 
MSG_TYPE_COLONNE_FULL EQU 2 
MSG_TYPE_PARTIE_GAGNER EQU 3 
MSG_TYPE_MATCH_NUL EQU 4 
MSG_TYPE_JOUEUR_JOUE EQU 5
MSG_TYPE_REJOUER EQU 6 
COLONNETOUCHE_LENGTH EQU 7 
ROUGE EQU $000000FF
JAUNE EQU $0000FFFF
BLANC EQU $00FFFFFF
BLUE EQU $00FF0000
NOIR EQU $00000000



COLONNELETTRE: DC.b 'azertyu'
TexteMatchNul: DC.B 'Match nul!',0 
Texte_Partie_Gagner: DC.B 'Player x a gagn�!',0
LettrePasTrouver: DC.B 'Touche invalide',0
Texte_Colonne_Remplie: DC.B 'Colonne remplie',0
Texte_Player1_Tour: DC.B 'Tour du player 1',0
Texte_Player2_Tour: DC.B 'Tour du player 2',0   
Texte_Erreur: DC.b 'Erreur',0
Texte_REJOUER: DC.b 'Voulez vous rejouer ? Y=Oui',0
MUSIQUE: DC.B 'classic.wav',0


*On met '$CC' afin de voir dans la fen�tre m�moire si les variables ont �t� correctement initialis�, on pourrai mettre 0, �a revient au m�me 
TypeMessageAfficher: DC.B $CC 
TOURJOUER: DC.w $CCCC
BufferLettre: DC.B $CC,$CC
JOUEURACTUEL: DC.b $CC
Tag_Joueur_Gagner: DC.B $CC 
 
*TAB: DC.b 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 
TAB: DCB.B 7*6,$CC * Bloque d�clar� de Bytes taille: 7*6, valeur: 0
 
   END START









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~