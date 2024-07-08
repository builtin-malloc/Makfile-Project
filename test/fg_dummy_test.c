#include "fg_dummy.h"

#include <assert.h>
#include <stdio.h>

int main(void) {
  printf("---------- %s \n", __FILE__);
  assert(fgDummy() == 0);
}
