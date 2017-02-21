CHECKBOX:
*'CHECKBOX' va v�rifier si la case actuelle est libre ou non, si le joueur peut jouer dans la case choisie, si c'est le cas alors il place l'ellipse � l'int�rieur
    MOVE.L  #TAB,A0 
    MOVE.L  #5,D6 *D6 = 5 car c'est la valeure maximum de ligne dans la grille

REPETE:
    MOVE.L  D5,D1 
    MULU    #6,D1 *En faisant �a, on est tout en haut de la colonne (D1 contient le num�ro de la case)  
    ADD.L   D6,D1 *On ajoute D6, qui est �gal � 5, pour �tre tout en bas de la colonne 
    MOVE.L  A0,A1 *On met A0 dans A1
    ADD.L   D1,A1 *On va au num�ro de D1 dans A1 (A1 = la grille en quelques sortes)
    CMP.B   #0,(A1) *Si le contenu de la case (D1) n'est pas �gale � 0, alors on va une ligne au dessus, et on r�p�t� ceci   
    BEQ     CaseLibreTrouver

    SUB.L #1,D6 *On soustrait 1 � D6 pour aller au dessus de la case actuelle, pour voir si c'est possible de mettre une ellipse � cet emplacement
    BPL REPETE
    MOVE.B #MSG_TYPE_COLONNE_FULL,TypeMessageAfficher
    JSR AffichageMessage
    
    RTS *On retourne dans le programme principale, apr�s le 'JSR CHECKBOX'  

CaseLibreTrouver:
    MOVE.B JOUEURACTUEL,(A1) *On met dans (A1) le num�ro du 'JOUEURACTUEL'
    CMP.b #2,JOUEURACTUEL *On v�rifie si le joueur actuel est le joueur num�ro 2 
    BEQ COULEURJOUEUR2 *Si c'est le cas, on va dans l'�tiquette 'COULEURJOUEUR2' 
    *Sinon, �a veut donc dire que c'est le joueur 1, il va executer la prochaine instruction qui est 'COULEURJOUEUR2'
    
COULEURJOUEUR1:
    MOVE.L #ROUGE,D1
    JSR SET_PEN_COLOR
    MOVE.L #ROUGE,D1
    JSR SET_FILL_COLOR
    BRA APPEL

COULEURJOUEUR2:
    MOVE.L #JAUNE,D1
    JSR SET_PEN_COLOR    
    MOVE.L #JAUNE,D1
    JSR SET_FILL_COLOR
    
APPEL:
    JSR DRAWELLIPSE *On appel le sousprogramme 'DRAWELLIPSE'
    EOR.B #3,JOUEURACTUEL *1 XOR 3 = 2 et 2 XOR 3 = 1 --> pour �changer les joueurs (pour qu'ils jouent chacun leurs tours)
    JSR TESTFORWINNER *On appel le sous programme 'TESTFORWINNER'
    ADD.w #1,TOURJOUER *Un tour a �t� jou�, donc on ajoute 1 � 'TOUJOUER'
APPEL2:    
    MOVE.B #MSG_TYPE_JOUEUR_JOUE,TypeMessageAfficher
    JSR AffichageMessage 
    RTS












*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~