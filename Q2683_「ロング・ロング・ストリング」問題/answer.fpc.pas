(* Try CodeIQ                      *)
(* author: Leonardone @ NEETSDKASU *)

Program CodeIQ;
Uses math;
Function MyFloor(K : Double) : Double;
Var Z : Double;
Begin
	Z := 3.0e4 * Floor(K / 3.0e4);
	MyFloor := Z + Floor(K - Z);
End;
Var M, B, T, X, Y : Double;
    Ans : Int64;
Begin
	ReadLn(M);
	B := 2.0;
	T := 1.0e10;
	Ans := -1;
	While B <= T Do
	Begin
		X := MyFloor((B + T) / 2.0);
		Y := 1.0 + MyFloor(X * Log10(X));
		If Y < M Then
				B := X + 1.0
		Else If Y > M Then
				T := X - 1.0
		Else
			Begin
				Ans := Floor(X);
				T := 0.0;
			End;
	End;
	WriteLn(Ans);
End.