#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>

void print_flag() {
    printf("COMP6841{ANOTHER_BAD_PROGRAM}");
}

int main(int argc, char * argv[]) {
  printf("It's taken a while but I think I've finally written a secure program\n");

  int flag = 1;
  if (flag == 0) print_flag();

  return 0;
}
