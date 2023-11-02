#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char FLAG[] = "COM\nP68\n41{\nWAI\nIT_\nTHE\nY_T\nOLD\n_ME\n_TH\nIS_\nWAS\n_SA\nFE}";

int main(void) {
  	int i, n ;
  	printf("Enter a number: ");
    scanf("%d", &n);
    for (i=1; i<=n; i++) {
        if (i % 15 == 0)        printf ("FizzBuzz\t");
        else if ((i % 3) == 0)  printf("Fizz\t");
        else if ((i % 5) == 0)  printf("Buzz\t");
        else                 	printf("%d\t", i);
    }

    return 0;
}
