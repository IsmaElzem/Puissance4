TESTFORWINNER:
*Ce programme va v�rifier si un joueur a gagn� ou non en v�rifiant toutes les possibilit�s, mais si le jeu a commenc� depuis moins de 7 tour, pas la pein de v�rifier s'il y a des gagnants vue que c'est en core impossible
    MOVE.L #TAB,A0 * On MOVE l'adresse de TAB dans A0
    CMP.W #6,TOURJOUER
    BLT APPEL2
*TEST VERTICALE
    MOVE #0,D1 *D1 = Colonne    
BoucleVerticalTestCol:
    MOVE #0,D2 *D2 = Lignes
BoucleVerticalTestLig:
*On fait cette partie pour trouver o� se trouve l'endroit o� le joueur a jouer (�a va nous retourner dans D4 une valeure entre 0 et 41)
    MOVE.L D1,D3 
    MULU.w #6,D3
    ADD.L D2,D3
    MOVE.B (A0,D3),D4 
*    
    TST.B D4 *On compare D4 avec 0 (gr�ce � TST), car une case vide contient 0 et dans ce cas l� ceci nous interesse pas 
    BEQ VerticalWinTestEchouer *Si c'est le cas, alors on va dans 'VerticalWinTestEchouer'
    MOVE.B 1(A0,D3),D5 *On regarde la case actuelle +1
    CMP.B D4,D5 *On compare pour vori si le contenu de celle ci est bien �gale � la valeur dans D4
    BNE VerticalWinTestEchouer *Si c'est pas le cas, alors on va dans 'VerticalWinTestEchouer'
    MOVE.B 2(A0,D3),D5 *On regarde la case actuelle +2
    CMP.B D4,D5
    BNE VerticalWinTestEchouer
    MOVE.B 3(A0,D3),D5 *On regarde la case actuelle +3
    CMP.B D4,D5
    BEQ WinFound *Si on arrive jusqu'ici, �a veut donc dire que D4,D4+1,D4+2,D4+3 contiennent tous les 4, 1 ou 2
VerticalWinTestEchouer:  
    ADD #1,D2 *On ajoute '1' � D2, qui correspond aux lignes
*On regarde si la ligne est �gale � 3 (Les lignes vont de 0 � 5, pour qu'un personne gagne verticalement, 
*il faut que 4 cases soit align�es verticalement. On consid�re que la 1er case tester est celle tout en haut
*Donc la 1er case est forcement entre [0,2] pour les lignes, et [0,6] pour les colonnes.
*Donc on test la 1er case du haut, et on descends vers le bas (avec +1,+2,+3) pour v�rifier le contenu des autres cases (cf l'image du tableau en annexe)
    CMP #3,D2 
    BNE BoucleVerticalTestLig
    ADD #1,D1
    CMP #7,D1 *Si D1 = 7 alors on a finit de v�rifier, car la colonne max dans notre tableau est 6
    BNE BoucleVerticalTestCol

*TEST HORIZONTALE

    MOVE #0,D1      
BoucleHorizontaleTestCol:
    MOVE #0,D2    
BoucleHorizontaleTestLig:
    MOVE.L D1,D3
    MULU.w #6,D3
    ADD.L D2,D3
    MOVE.B (A0,D3),D4
    TST.B D4   
    BEQ HorizontaleWinTestEchouer
*Horizontale test
    MOVE.B 6(A0,D3),D5 *On regarde case actuelle +6
    CMP.B D4,D5
    BNE HorizontaleWinTestEchouer
    MOVE.B 12(A0,D3),D5 *On regarde case actuelle +12
    CMP.B D4,D5
    BNE HorizontaleWinTestEchouer
    MOVE.B 18(A0,D3),D5 *On regarde case actuelle +18
    CMP.B D4,D5
    BEQ WinFound     
HorizontaleWinTestEchouer:
    ADD #1,D2
    CMP #6,D2
    BNE BoucleHorizontaleTestLig 
    ADD #1,D1
 *Ici, la colonne maximale � regarder est la 3eme, vue qu'on regarde d'abord la 1er case et celle qui suit (vers la droite).
 *Donc si la 1er case est aux coordonn�es [4,0], alors il ne peut avoir que 3 '1/2' � la suite
    CMP #4,D1
    BNE BoucleHorizontaleTestCol 

*DIAGONALE NORD EST
*On regarde les cases qui vont du bas gauche vers le haut droit horizontalement
    
    MOVE #0,D1
DiagonaleEastTestColLoop:
    MOVE #0,D2    
DiagonaleEastTestRowLoop:
    MOVE.L D1,D3
    MULU.w #6,D3
    ADD.L D2,D3
    MOVE.B (A0,D3),D4
    TST.B D4   
    BEQ DiagonaleEastWinTestFailed
*Diagonale nord est test
    MOVE.B 7(A0,D3),D5 *On regarde case actuelle +7
    CMP.B D4,D5
    BNE DiagonaleEastWinTestFailed
    MOVE.B 14(A0,D3),D5 *On regarde case actuelle +14
    CMP.B D4,D5
    BNE DiagonaleEastWinTestFailed
    MOVE.B 21(A0,D3),D5 *On regarde case actuelle +21
    CMP.B D4,D5
    BEQ WinFound     
DiagonaleEastWinTestFailed:
    ADD #1,D2
    CMP #3,D2
    BNE DiagonaleEastTestRowLoop *fin 1er boucle
    ADD #1,D1
    CMP #4,D1
    BNE DiagonaleEastTestColLoop *fin 2eme boucle    
    
*DIAGONALE SUD EST
*On regarde les cases qui vont du bas gauche vers le haut droit horizontalement    
    MOVE #0,D1
BoucleDiagonaleOuestTestCol:
    MOVE #2,D2 *On fait commencer D2 � 2 pour celui ci  
BoucleDiagonaleWestTestLig:
    MOVE.L D1,D3
    MULU.w #6,D3
    ADD.L D2,D3
    MOVE.B (A0,D3),D4
    TST.B D4   
    BEQ DiagonaleOuestWinTestEchouer
*Diagonale sud est test
    MOVE.B 5(A0,D3),D5 *On regarde case actuelle +5
    CMP.B D4,D5
    BNE DiagonaleOuestWinTestEchouer
    MOVE.B 10(A0,D3),D5 *On regarde case actuelle +10
    CMP.B D4,D5
    BNE DiagonaleOuestWinTestEchouer
    MOVE.B 15(A0,D3),D5 *On regarde case actuelle +15
    CMP.B D4,D5
    BEQ WinFound     
DiagonaleOuestWinTestEchouer:
    ADD #1,D2
    CMP #6,D2
    BNE BoucleDiagonaleWestTestLig *fin 1er boucle
    ADD #1,D1
    CMP #4,D1
    BNE BoucleDiagonaleOuestTestCol *fin 2eme boucle    
    RTS



WinFound:
        ADD.B #'0',D5 *On fait ceci car 'DRAW_STRING' n'a que des charact�res, on 'r�serve' en quelques sortes les pixels o� le chiffre du vainqueur va �tre afficher (cf AffichageMessage, label 'Partie_Gagner')
        MOVE.B D5,Tag_Joueur_Gagner
        MOVE.B #MSG_TYPE_PARTIE_GAGNER,TypeMessageAfficher
        JSR AffichageMessage
        BRA HandleRestartGame *Lorsqu'un joueur a gagn�, on appel le sous programme 'HandleRestartGame' afin de r�initialiser les valeurs de certaines variabls 

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~