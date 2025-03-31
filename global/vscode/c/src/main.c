#include <stdio.h>
#include "functions.h"

int main(int argc, char *argv[]) {
	puts(PROJECT_NAME);
	int a = add(2, 2);
	printf("%d\n", a);
	return 0;
}
