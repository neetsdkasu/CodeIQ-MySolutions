/* C言語
 * CodeIQ Q575 解答
 *
 * 2013/11/27 レナドーン◆NEETSDKASU
 */
#include <stdio.h>
#include <string.h>

#define BUFSIZE (200)
#define LIMIT (10000)

int symmetry(const char *str);
int toBits(char *bits, int num);

int main(void) {
    char str[BUFSIZE];
    int i = 10;
    
    for ( ;; i++) {
        if (i > LIMIT) {
            printf("Over limit.\n");
            break;
        }
        sprintf(str, "%d", i);
        if (!symmetry(str)) continue;
        sprintf(str, "%o", i);
        if (!symmetry(str)) continue;
        toBits(str, i);
        if (!symmetry(str)) continue;
        printf("%d\n%o\n%s\n", i, i, str);
        break;
    }
    
    return 0;
}

int symmetry(const char *str) {
    int len = strlen(str);
    int half = len / 2;
    int i;
    
    for (i = 0; i < half; i++) {
        if (str[i] != str[len - i - 1]) {
            return 0;
        }
    }
    return 1;
}

int toBits(char *bits, int num) {
    char temp[BUFSIZE];
    int i, c = 0;
    while (num > 0) {
        temp[c++] = '0' + (char)(num % 2);
        num >>= 1;
    }
    for (i = 0; i < c; i++) {
        bits[i] = temp[c - i - 1];
    }
    bits[c] = '\0';
    return c;
}
