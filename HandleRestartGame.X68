HandleRestartGame:
*Ce petit programme sert à afficher le texte 'Texte_REJOUER' , à des coordonnés précis. On demande par la suite d'entré une valeur
*Si c'est 'y' alors on va au label 'START' sinon c'est la fin du programme (cette partie là est dans le main ligne 113)
        MOVE #120,D1
        MOVE #435,D2
        MOVE #Texte_REJOUER,A1
        JSR DRAW_STRING
        JSR SAISCAR
        CMP.b #'y',D1
        BEQ START
