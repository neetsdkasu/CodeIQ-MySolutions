// Try CodeIQ Q3463
// author: Leonrdone @ NEETSDKASU
import std.stdio     : readln, writeln;
import std.array     : split;
import std.algorithm : map, min, max;
import std.string    : chomp;
import std.conv      : to;

void main()
{
    auto xss = readln.chomp.split(" ").map!( (x) => x.split(",").to!(int[]) );
    auto fst = xss[0], snd = xss[1];
    bool inCircle(int[] cir, int x, int y)
    {
        auto dx = x - cir[0], dy = y - cir[1];
        return dx * dx + dy * dy <= cir[2] * cir[2];
    }
    auto left   = max(fst[0] - fst[2], snd[0] - snd[2]);
    auto right  = min(fst[0] + fst[2], snd[0] + snd[2]);
    auto top    = max(fst[1] - fst[2], snd[1] - snd[2]);
    auto bottom = min(fst[1] + fst[2], snd[1] + snd[2]);
    auto ans = 0;
    if (fst == snd)
    {
        for (auto y = top; y <= fst[1]; y++)
        {
            for (auto x = left; x < fst[0]; x++)
            {
                if (inCircle(fst, x, y))
                {
                    ans++;
                }
            }
        }
        ans *= 4;
        ans++;
    }
    else
    {
        for (auto y = top; y <= bottom; y++)
        {
            for (auto x = left; x <= right; x++)
            {
                if (inCircle(fst, x, y) && inCircle(snd, x, y))
                {
                    ans++;
                }
            }
        }
    }
    writeln(ans);
}