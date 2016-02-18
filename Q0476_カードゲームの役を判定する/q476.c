/* *************************************************************************** *
 * My Answer for CodeIQ Q476
 * Author: Leonardone @ NEETSDKASU
 *
 * 私の解答 (残念ながら不正解でした)
 * An:333,sDT:22,DT:446,scTP:10,cTP:614,sTP:556,TP:7829
 *
 * *************************************************************************** */
 
/*
 * q476.c
 *
 * CodeIQ q476
 *
 */
#include <stdio.h>

/* 手札の枚数 */
#define TEFUDA 6

/* スートへの番号の割り当て */
#define CLUB   0
#define DIA    1
#define HEART  2
#define SPADE  3

/* 役の数（役なし含む） */
#define YAKU   8

/* 役への番号の割り当て */
#define Y___An 0
#define Y__sDT 1
#define Y___DT 2
#define Y_scTP 3
#define Y__cTP 4
#define Y__sTP 5
#define Y___TP 6
#define Y_None 7

/* printHand()でのスート表示用 */
const char SUITS[] = "CDHS";

/* 役を判定する関数 */
int hantei(int *num, int *suit);

/* １セットの手札と役を表示する関数 */
void printHand(int *num, int *suit, int yaku);


int main()
{
    int num[TEFUDA];        /* 手札１セットのカードの数字 */
    int suit[TEFUDA];       /* 手札１セットのカードのスート */
    int yakucount[YAKU];    /* 役のカウント */
    int yaku;               /* hanteiの戻り値の役を受け取る */
    int i;                  /* ループカウンタ */
    int t;                  /* 手札のカード番号 */
    char c;                 /* 入力された文字用 */
    
    /* 変数の初期化 */
    for (i = 0; i < TEFUDA; i++) {
        num[i] = 0;
    }
    for (i = 0; i < YAKU; i++) {
        yakucount[i] = 0;
    }
    
    /* stdin からデータを入力する */
    t = 0;
    while ((c = getchar()) != EOF) {
        switch (c) {
        case '\n':
        case '\r':
            if (t != 0) {
                t = 0;
                yaku = hantei(num, suit);
                yakucount[yaku]++;
                
                /* 手札と役の表示（動作確認用）*/
                /* printHand(num, suit, yaku); */
            }
            break;
        case ',':
            t++;
            break;
        case 'C':
            suit[t] = CLUB;
            break;
        case 'D':
            suit[t] = DIA;
            break;
        case 'H':
            suit[t] = HEART;
            break;
        case 'S':
            suit[t] = SPADE;
            break;
        case 'A':
            num[t] = 1;
            break;
        case 'J':
            num[t] = 11;
            break;
        case 'Q':
            num[t] = 12;
            break;
        case 'K':
            num[t] = 13;
            break;
        case '1':
            num[t] = 10;
            break;
        case '0':
            break;
        default:
            num[t] = (int)(c - '0');
            break;
        }
    }
    
    /* 結果表示 */
    printf("An:%d", yakucount[Y___An]);
    putchar(',');
    printf("sDT:%d", yakucount[Y__sDT]);
    putchar(',');
    printf("DT:%d", yakucount[Y___DT]);
    putchar(',');
    printf("scTP:%d", yakucount[Y_scTP]);
    putchar(',');
    printf("cTP:%d", yakucount[Y__cTP]);
    putchar(',');
    printf("sTP:%d", yakucount[Y__sTP]);
    putchar(',');
    printf("TP:%d", yakucount[Y___TP]);
    putchar('\n');
    
    return 0;
}

/* 役の判定をする関数
 *
 * num  手札の数字
 * suit 手札のスート
 */
int hantei(int *num, int *suit)
{
    int pair[TEFUDA]; /* ペアやトリオやアンサーの情報を格納する */
    int suitcount[4]; /* 手札内のスートの数 */
    int numbers[14];  /* 手札内の数字の数 */
    int i, j;         /* ループカウンタ */
    int torio;        /* トリオ確認フラグ */
    int answer;       /* アンサー確認フラグ */
    int cont;         /* コント確認フラグ */
    
    /* 変数の初期化 */
    for (i = 0; i < TEFUDA; i++) {
        pair[i] = 0;
    }
    torio = 0;
    answer = 0;
    
    /* ペアやトリオやアンサーを調べる */
    for (i = 0; i < TEFUDA - 1; i++) {
        for (j = i + 1; j < TEFUDA; j++) {
            if (num[i] == num[j]) {
                pair[i]++;
                pair[j]++;
            }
        }
        switch (pair[i]) {
        case 0: /* 組をつくらない数字がある */
            return Y_None;
        case 2: /* ３枚組の数字がある */
            torio++;
            break;
        case 3: /* ４枚組の数字がある */
            answer++;
            break;
        default:
            break; 
        }
    }
    
    /* アンサーの役を決める */
    if (answer > 0) {
        return Y___An;
    }

    /* 変数の初期化 */
    for (i = 0; i < 4; i++) {
        suitcount[i] = 0;
    }
    /* スートの数を調べる  */
    for (i = 0; i < TEFUDA; i++) {
        suitcount[suit[i]]++;
    }

    /* トリオの役を決める */
    if (torio > 0) {
        for (i = 0; i < 4; i++) { /* シンクの確認 */
            if (suitcount[i] == 1) {
                return Y___DT;
            }
        }
        return Y__sDT;
    }
    
    /* 変数の初期化 */
    for (i = 0; i < 14; i++) {
        numbers[i] = 0;
    }
    /* 各数字のカードの枚数を数える */
    for (i = 0; i < TEFUDA; i++) {
        numbers[num[i] - 1]++;
        if (num[i] == 0) {
            numbers[13]++;
        }
    }
    /* コントを調べる */
    cont = 0;
    for (i = 0; i < 14 - 2; i++) {
        if (numbers[i] > 0) {
            if ((numbers[i + 1] > 0) && (numbers[i + 2] > 0)) {
                cont++;
            }
            break;
        }
    }
    /* ペアの役を決める */
    for (i = 0; i < 4; i++) { /* シンクの確認 */
        if ((suitcount[i] == 1) || (suitcount[i] == 2)) {
            if (cont > 0) {
                return Y__cTP;
            } else {
                return Y___TP;
            }
        }
    }
    if (cont > 0) {
        return Y_scTP;
    } else {
        return Y__sTP;
    }
}

/* カードと役を表示する関数
 *
 * num  手札の数字
 * suit 手札のスート
 * yaku 手札の役
*/
void printHand(int *num, int *suit, int yaku)
{
    int i;
    for (i = 0; i < TEFUDA; i++) {
        printf("%C%d,", SUITS[suit[i]], num[i]);
    }
    switch (yaku) {
    case Y___An:
        printf(" An\n");
        break;
    case Y__sDT:
        printf(" sDT\n");
        break;
    case Y___DT:
        printf(" DT\n");
        break;
    case Y_scTP:
        printf(" scTP\n");
        break;
    case Y__cTP:
        printf(" cTP\n");
        break;
    case Y__sTP:
        printf(" sTP\n");
        break;
    case Y___TP:
        printf(" TP\n");
        break;
    default:
        printf(" -\n");
        break;
    }       
}
