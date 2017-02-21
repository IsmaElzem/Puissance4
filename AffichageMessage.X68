AffichageMessage: 
*'AffichageMessage permet d'afficher un message à l'écran, avant chaque 'JSR AffichageMessage', on fait un 'MOVE.B #MSG_TYPE_XXXX,TypeMessageAfficher', où XXXXX est remplacer par 
*le nom de la variable du texte à afficher (qui est un chiffre),  et on le met dans 'TypeMessageAfficher', et ce sera ce dernier qu'on regardera dans ce programme 
*afin de voir quel message il faut afficher 



*Ici, on va dessinner un rectangle en bas de la grille, il va contenir les divers messages pendant le jeu (colonne remplie, partie gagner...).
*On prepare donc le rectange (couleur du stylo, couleur du remplissement,coordonnés,dimension) et ensuite on vérifie quel message on doit afficher. 
*Lorsque ce message est trouvé, on le place aux coordonnés 'TEXT_MSG_X' et 'TEXT_MSG_Y', déclaré dans le main avec des valeures fixes et on l'affiche.         
	    MOVE.L #BLUE,D1
    	JSR SET_PEN_COLOR
    	MOVE.L #NOIR,D1
    	JSR SET_FILL_COLOR
        MOVE.W #130,D1
        MOVE.W #400,D2
        MOVE.W #320,D3
        MOVE.W #420,D4
        JSR DRAW_FILL_RECT
	    JSR PrepareGameMessage
	    MOVE #TEXT_MSG_X,D1
    	MOVE #TEXT_MSG_Y,D2
 	    JSR DRAW_STRING
	    RTS
	     
	     
	     
	    

*Plusieurs bloque de if/else afin de vérifier quel est le message a afficher, la valeure retourner sera A1 (le message sera contenue dedans)	    
PrepareGameMessage:
	    CMP.b #MSG_TYPE_MAUVAISE_TOUCHE,TypeMessageAfficher	
	    BNE IF_FULL_COLONNE
INVALIDE_TOUCHE:
    	MOVE #LettrePasTrouver,A1
	    RTS
IF_FULL_COLONNE:
	    CMP.b #MSG_TYPE_COLONNE_FULL,TypeMessageAfficher
	    BNE IF_MATCH_NUL
*COLONNE_REMPLIE:
    	MOVE #Texte_Colonne_Remplie,A1
	    RTS
IF_MATCH_NUL:
        CMP.B #MSG_TYPE_MATCH_NUL,TypeMessageAfficher
	    BNE IF_PARTIE_GAGNER
*MATCH_NUL:
    	MOVE #TexteMatchNul,A1
	    RTS
IF_PARTIE_GAGNER:
        CMP.B #MSG_TYPE_PARTIE_GAGNER,TypeMessageAfficher
        BNE IF_JOUEUR_JOUE
*PARTIE_GAGNER:	
   	    MOVE.L #Texte_Partie_Gagner,A1
        MOVE.B Tag_Joueur_Gagner,D4 *Tag_Joueur_Gagner contient le numéro du joueur gagnant 
    	MOVE.B D4,7(A1) *On le place après la 7eme position de 'Texte_Partie_Gagner' (ça va remplacer le 'x' de cette chaine). 
	    RTS
IF_JOUEUR_JOUE:
        CMP.B #MSG_TYPE_JOUEUR_JOUE,TypeMessageAfficher
        BNE TYPE_MSG_INCONNUE
*PLAYER_PLAY:
        CMP.B #2,JOUEURACTUEL
        BNE PLAYER1_PLAY
PLAYER2_PLAY:
        MOVE.L #Texte_Player2_Tour,A1
        RTS 
PLAYER1_PLAY:
        MOVE.L #Texte_Player1_Tour,A1
        RTS       
TYPE_MSG_INCONNUE:
        MOVE.L #Texte_Erreur,A1
        RTS
        

	    




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
