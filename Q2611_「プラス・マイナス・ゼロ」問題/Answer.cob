*> Try CodeIQ
       *> author: Leonardone @ NEETSDKASU
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       REPOSITORY.
              FUNCTION ALL INTRINSIC.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 Variables.
              05 n         USAGE IS BINARY-SHORT.
              05 arr       OCCURS 4000 TIMES.
                     10 m     USAGE IS BINARY-DOUBLE.
                     10 t     USAGE IS BINARY-DOUBLE.
              05 s         USAGE IS BINARY-SHORT.
              05 i         USAGE IS BINARY-SHORT.
              05 j         USAGE IS BINARY-SHORT.
              05 k         USAGE IS BINARY-SHORT.
              05 ans       USAGE IS BINARY-SHORT.
              05 show      PIC Z(20)9.
       PROCEDURE DIVISION.
       000-Input SECTION.
              ACCEPT n.
              
       001-Init SECTION.
              MOVE 1 TO m(2000).
       
       002-Calc SECTION.
              IF i = n THEN
                     GO TO 005-Show-Answer
              END-IF.
              ADD 1 TO i.
              IF s = 0 THEN
                     MOVE 1 TO s
                     GO TO 003-M-to-T
              ELSE
                     MOVE 0 TO s
                     GO TO 004-T-to-M
              END-IF.
       
       003-M-to-T SECTION.
              PERFORM WITH TEST AFTER
              VARYING j FROM 1 BY 1 UNTIL j >= 4000
                     IF m(j) > 0 THEN
                            MOVE j TO k
                            ADD i TO k
                            ADD m(j) TO t(k)
                            MOVE j TO k
                            SUBTRACT i FROM k
                            ADD m(j) TO t(k)
                            MOVE 0 TO m(j)
                     END-IF
              END-PERFORM.
              GO TO 002-Calc.
              
       004-T-to-M SECTION.
              PERFORM WITH TEST AFTER
              VARYING j FROM 1 BY 1 UNTIL j >= 4000
                     IF t(j) > 0 THEN
                           MOVE j TO k
                           ADD i TO k
                           ADD t(j) TO m(k)
                           MOVE j TO k
                           SUBTRACT i FROM k
                           ADD t(j) TO m(k)
                           MOVE 0 TO t(j)
                     END-IF
              END-PERFORM.
              GO TO 002-Calc.
       
       005-Show-Answer SECTION.
              IF s = 0 THEN
                     MOVE m(2000) TO show
              ELSE
                     MOVE t(2000) TO show
              END-IF.
              DISPLAY TRIM(show).
              
       END PROGRAM Main.