// Try CodeIQ
// author: Leonardone @ NEETSDKASU

import java.util.*;

public class Main
{
    public static void main(String[] args) throws Exception
    {
        Scanner in = new Scanner(System.in);
        int n = in.nextInt();
        int MAX = 'z' - 'a' + 1;
        boolean[][] maru = new boolean[MAX][MAX];
        {
            for (String pos : in.next().split(","))
            {
                int x = (int)pos.charAt(0) - 'A';
                int y = (int)pos.charAt(1) - 'a';
                maru[y][x] = true;
            }
        }
        boolean[][] batu = new boolean[MAX][MAX];
        {
            for (String pos : in.next().split(","))
            {
                int x = (int)pos.charAt(0) - 'A';
                int y = (int)pos.charAt(1) - 'a';
                batu[y][x] = true;
            }
        }
        int ans = 0;
        for (int y0 = 0; y0 < MAX; y0++)
        {
            for (int x0 = 0; x0 < MAX; x0++)
            {
                for (int y1 = y0; y1 < MAX; y1++)
                {
                    for (int x1 = x0; x1 < MAX; x1++)
                    {
                        int c = 0;
                        boolean f = true;
                    loop_y:
                        for (int y = y0; y <= y1; y++)
                        {
                            for (int x = x0; x <= x1; x++)
                            {
                                if (maru[y][x])
                                {
                                    c++;
                                }
                                if (c > n)
                                {
                                    f = false;
                                    break loop_y;
                                }
                                if (batu[y][x])
                                {
                                    f = false;
                                    break loop_y;
                                }
                            }
                        }
                        if (f && c == n)
                        {
                            ans = Math.max(ans, (y1 - y0 + 1) * (x1 - x0 + 1));
                        }
                    }
                }

            }
        }
        if (ans > 0)
        System.out.println(ans);
        else
        System.out.println("-");
    }
}