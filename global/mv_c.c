#include <dirent.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <sys/stat.h>
#include <unistd.h>


#define pRED(x)   "[\033[1;95m-- " x " --\033[0m] "
#define pYELLO(x) "[\033[1;33m-- " x " --\033[0m] "
#define pCYAN(x)  "[\033[1;36m-- " x " --\033[0m] "
#define pBLUE(x)  "[\033[1;31m-- " x " --\033[0m] "

#define TARGET_DIRECT "/Users/pritam/Downloads/"

static char full_path[PATH_MAX] = { '\0' };


bool endsWith(const char *str, const char *suffix);
bool strStartsWtith(const char *pre, const char *str);
void createDirs(void);


int main(void) {
	chdir(TARGET_DIRECT);
	createDirs();
	DIR *dp           = NULL;
	struct dirent *ep = NULL;
	dp = opendir(".");

	if (dp != NULL) {
		while ((ep = readdir(dp)) != NULL) {
			if (ep->d_type == DT_REG) {
				if (strStartsWtith("WhatsApp", ep->d_name)) {
					snprintf(full_path, PATH_MAX, "whatsapp/%s", ep->d_name);
					printf(pRED("WhatsApp") "\"%s\"\n", ep->d_name);
					rename(ep->d_name, full_path);
				}
				else if   (endsWith(ep->d_name, ".png")  ||
				           endsWith(ep->d_name, ".jpeg") ||
				           endsWith(ep->d_name, ".heic") ||
				           endsWith(ep->d_name, ".svg")  ||
				           endsWith(ep->d_name, ".jpg")) {
					snprintf(full_path, PATH_MAX, "image/%s", ep->d_name);
					printf(pYELLO("Image") "\"%s\"\n", ep->d_name);
					rename(ep->d_name, full_path);
				}
				else if   (endsWith(ep->d_name, ".pdf")  ||
				           endsWith(ep->d_name, ".docx") ||
				           endsWith(ep->d_name, ".doc")) {
					snprintf(full_path, PATH_MAX, "doc/%s", ep->d_name);
					printf(pCYAN("Doc") "\"%s\"\n", ep->d_name);
					rename(ep->d_name, full_path);
				}
				else if (endsWith(ep->d_name, ".pptx") ||
				           endsWith(ep->d_name, ".ppt")) {
					snprintf(full_path, PATH_MAX, "doc/ppt/%s", ep->d_name);
					printf(pCYAN("Doc/ppt") "\"%s\"\n", ep->d_name);
					rename(ep->d_name, full_path);
				}
			}
		}
	}
	else {
		perror("Couldn't open the directory { " TARGET_DIRECT " }");
		return -1;
	}
	printf(pBLUE("Done") "\n");
	closedir(dp);
	return 0;
}

bool strStartsWtith(const char *pre, const char *str) {
	return strncmp(pre, str, strlen(pre)) == 0;
}

bool endsWith(const char *str, const char *suffix) {
	if (!str || !suffix) return 0;
	size_t lenstr    = strlen(str);
	size_t lensuffix = strlen(suffix);
	if (lensuffix > lenstr) return 0;
	return strncmp(str + lenstr - lensuffix, suffix, lensuffix) == 0;
}

void createDirs(void) {
	const char *const folders[] = { "whatsapp", "image", "doc", "doc/ppt", NULL };

	for (size_t i = 0; folders[i]; i++) {
		if (access(folders[i], F_OK) != 0) {
			mkdir(folders[i], 0755);
		}
	}
}
