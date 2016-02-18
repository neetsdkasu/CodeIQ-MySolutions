        PROGRAM-ID.X.DATA DIVISION.WORKING-STORAGE SECTION. 01 v.
        03 i PIC 999. 03 j PIC 999 VALUE 1. 03 z PIC Z(20)9.
        03 w OCCURS 101 TIMES. 05 a PIC 9(20). 05 b PIC 9(20).
        05 c PIC 9(20). 05 d PIC 9(20). 05 f PIC 9(20).
        PROCEDURE DIVISION.m SECTION.MOVE 1 TO a(1).p.ADD 1 TO i j.
        MOVE FUNCTION SUM(a(i),b(i),c(i),d(i),f(i))TO z.
        DISPLAY FUNCTION TRIM(z).ADD d(i)f(i)TO a(j).
        ADD a(i)d(i)TO b(j).MOVE b(i)TO c(j).MOVE f(i)TO d(j).
        MOVE c(i)TO f(j).IF i<100 THEN GO TO p.
