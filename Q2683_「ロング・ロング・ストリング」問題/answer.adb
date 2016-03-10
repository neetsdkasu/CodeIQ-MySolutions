-- Try CodeIQ
-- author: Leonardone @ NEETSDKASU
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

procedure CodeIQ is
	--
	function F (N : Long_Long_Integer) return Long_Long_Integer is
		package LF is new Ada.Numerics.Generic_Elementary_Functions (Long_Float);
		D : Long_Float := Long_Float(N);
	begin
		D := 1.0 + Long_Float'Floor(D * LF.Log(D, 10.0)); -- 間違っていたので修正
		return Long_Long_Integer(D);
	end F;
	--
	function G (M : Long_Long_Integer) return Long_Long_Integer is
		function H (B, T : Long_Long_Integer) return Long_Long_Integer is
			X, Y : Long_Long_Integer;
		begin
			if B > T then
				return -1;
			else
				X := (B + T) / 2;
				Y := F (X);
				if Y < M then
					return H (X + 1, T);
				elsif Y > M then
					return H (B, X - 1);
				else
					return X;
				end if;
			end if;
		end H;
	begin
		return H (2, 10 ** 10);
	end G;
	--
	package LIO is new Ada.Text_IO.Integer_IO (Long_Long_Integer);
	M : Long_Long_Integer;
	Ans : Long_Long_Integer;
begin
	LIO.Get (M);
	Ans := G (M);
	LIO.Put (Ans, 0);
	New_Line;
end CodeIQ;