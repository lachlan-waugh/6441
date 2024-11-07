#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
  char name[40];
  int age;
} person_t;

void set_name(person_t *person, char *name) {
  strcpy(person->name, name);
}

void set_age(person_t *person, int age) {
  person->age = age;
}

person_t *create() {
  person_t *p = malloc(sizeof(person_t));
  set_name(p, "Lachlan");
  set_age(p, 123);

  return p;
}

int main(void) {
  printf("hello\n");
  return 0;
}
