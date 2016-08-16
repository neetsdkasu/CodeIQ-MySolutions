/*
 * C言語
 * CodeIQ Q543 解答 （修正）
 * ２進数を文字列にして左右対称になるように下位桁を書き換えることによって求めた
 * 2013/11/27 レナドーン@NEETSDKASU
 */
#include <stdio.h>

int toBits(char *bits, int n);
int toDigit(const char *bits);

int main(void) {
    char bits[100];
    int now, len, half, res, i;
    int start = 19641010;
    int end   = 20200724;
    int y, m, d, f, c = 0;
    
    now = start;
    while (now <= end) {
        len = toBits(bits, now);
        half = len / 2;
        for (i = 0; i < half; i++) {
            bits[len - i - 1] = bits[i];
        }
        res = toDigit(bits);
        if ((res >= start) && (res <= end)) {
            y = res / 10000;
            m = (res / 100) % 100;
            d = res % 100;
            f = 0;
            if ((m > 0) && (m < 13) && (d > 0)) {
                switch (m) {
                case 2:
                    if ((y % 400) == 0) {
                        if (d < 30) f = 1;
                    } else if ((y % 100) == 0) {
                        if (d < 29) f = 1;
                    } else if ((y % 4) == 0) {
                        if (d < 30) f = 1;
                    } else if (d < 29) {
                        f = 1;
                    }
                    break;
                case 4:
                case 6:
                case 9:
                case 11:
                    if (d < 31) f = 1;
                    break;
                default:
                    if (d < 32) f = 1;
                    break;
                }
                if (f) {
                    if (c++) putchar(',');
                    printf("%d", res);
                }
            }
        }
        now += 1 << (half + (len % 2));
    }
    putchar('\n');
    return 0;
}

int toBits(char *bits, int n) {
    char temp[100];
    int d, i = 0, j;
    while (n > 0) {
        d = n % 2;
        n = n / 2;
        temp[i++] = '0' + (char)d;
    }
    for (j = 0; j < i; j++) {
        bits[j] = temp[i - j - 1];
    }
    bits[j] = '\0';
    return j;
}

int toDigit(const char *bits) {
    int n = 0;
    while (*bits != '\0') {
        n = (n << 1) | (int)(*bits++ - '0');
    }
    return n;
}
