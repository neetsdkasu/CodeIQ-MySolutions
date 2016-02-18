' Try CodeIQ
' author: Leonardone @ NEETSDKASU
Imports System
 
Module Main
	Sub Main()
	    Dim n%, i%, j%:
	    Dim a&(4000), b&(4000), ans&
	    n = CInt(Console.ReadLine)
	    a(2000) = 1
	    For i = 1 To n
	        If i Mod 2 = 0 Then
	            For j = 0 To 4000
	                If b(j) = 0 Then Continue For
	                a(j + i) += b(j)
	                a(j - i) += b(j)
	                b(j) = 0
	            Next j
	        Else
	            For j = 0 To 4000
	                If a(j) = 0 Then Continue For
	                b(j + i) += a(j)
	                b(j - i) += a(j)
	                a(j) = 0
	            Next j
	        End If
	    Next i
	    ans = IIf(n Mod 2 = 0, a(2000), b(2000))
	    Console.WriteLine(ans)
	End Sub
End Module