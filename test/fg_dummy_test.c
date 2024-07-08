#include "fg_dummy.h"

#include <stdio.h>
#include <assert.h>

int main(void) {
  printf("---------- %s \n", __FILE__);
  assert(fgDummy() == 0);
}
