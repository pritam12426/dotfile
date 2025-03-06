#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define ANSI_COLOR_GREEN   "\x1b[32m"
#define ANSI_COLOR_RED     "\x1b[31m"
#define ANSI_COLOR_YELLOW  "\x1b[33m"
#define ANSI_COLOR_BLUE    "\x1b[34m"
#define ANSI_COLOR_MAGENTA "\x1b[35m"
#define ANSI_COLOR_CYAN    "\x1b[36m"
#define ANSI_COLOR_WHITE   "\x1b[97m"
#define ANSI_COLOR_RESET   "\x1b[0m"

static char *PATH_VAR          = NULL;
static char *MAN_PATH_VAR      = NULL;
static char *CMAKE_PATH_VAR    = NULL;
static char *PKG_CONFIG_PATH   = NULL;
static char *DYLD_LIBRARY_PATH = NULL;

uint32_t print_var(const char *var, const char *name) {
	printf(ANSI_COLOR_GREEN "Printing variable: " ANSI_COLOR_RED
	                        "%s\n" ANSI_COLOR_RESET,
	       name);
	if (var == NULL) {
		return 0;
	}

	int j = 2;
	printf(ANSI_COLOR_CYAN "1   -- " ANSI_COLOR_RESET);
	for (int i = 0; var[i]; i++) {
		if (var[i] == ':' && var[i + 1] == '\0') {
			continue;
		} else if (var[i] == ':') {
			putchar('\n');
			printf(ANSI_COLOR_WHITE "%-3d -- " ANSI_COLOR_RESET, j);
			j++;
			continue;
		}
		putchar(var[i]);
	};
	printf("\n");
	return --j;
}

void after_print(const uint32_t n) {
	printf(ANSI_COLOR_YELLOW "    Summary: " ANSI_COLOR_MAGENTA
	                         "The variable contains " ANSI_COLOR_CYAN
	                         "%u" ANSI_COLOR_MAGENTA
	                         " distinct paths.\n\n" ANSI_COLOR_RESET,
	       n);
}

int main(void) {
	uint32_t x        = 0;
	PATH_VAR          = getenv("PATH");
	MAN_PATH_VAR      = getenv("MANPATH");
	CMAKE_PATH_VAR    = getenv("CMAKE_MODULE_PATH");
	PKG_CONFIG_PATH   = getenv("PKG_CONFIG_PATH");
	DYLD_LIBRARY_PATH = getenv("DYLD_LIBRARY_PATH");


	x = print_var(PATH_VAR, "PATH");
	after_print(x);

	x = print_var(MAN_PATH_VAR, "MANPATH");
	after_print(x);

	x = print_var(CMAKE_PATH_VAR, "CMAKE_PATH_VAR");
	after_print(x);

	x = print_var(PKG_CONFIG_PATH, "PKG_CONFIG_PATH");
	after_print(x);

	x = print_var(DYLD_LIBRARY_PATH, "DYLD_LIBRARY_PATH");
	after_print(x);
	return 0;
}
