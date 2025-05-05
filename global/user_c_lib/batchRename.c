// Project name: batchRenamer

#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/types.h>

#include "functions.h"

#define TEMP_FILE_PATH "/private/tmp/batchRename.txt"

// Helper function declarations
maxPair countFilesAndMaxNameLen(const char *directoryPath);
int isDotOrDotDot(const char *name);

int main(int argc, char *argv[]) {
	const char *directoryPath = (argc == 2) ? argv[1] : ".";

	struct stat st;
	if (stat(directoryPath, &st) != 0 || !S_ISDIR(st.st_mode)) {
		fprintf(stderr, "Directory does not exist!\n");
		return EXIT_FAILURE;
	}

	chdir(directoryPath);

	maxPair fileStats = countFilesAndMaxNameLen(".");
	if (fileStats.count == 0) {
		printf("No files to rename.\n");
		return EXIT_SUCCESS;
	}

	pathPair *filePairs = calloc(fileStats.count, sizeof(pathPair));
	if (!filePairs) {
		perror("Memory allocation failed");
		return EXIT_FAILURE;
	}

	FILE *file = fopen(TEMP_FILE_PATH, "w");
	if (!file) {
		perror("Failed to open temp file for writing");
		free(filePairs);
		return EXIT_FAILURE;
	}

	DIR *dir = opendir(".");
	if (!dir) {
		perror("Failed to open directory");
		fclose(file);
		free(filePairs);
		return EXIT_FAILURE;
	}

	struct dirent *entry;
	size_t index = 0;

	// Write current names to temp file
	while ((entry = readdir(dir)) != NULL) {
		if (isDotOrDotDot(entry->d_name)) continue;
		strncpy(filePairs[index].currentName, entry->d_name, PATH_MAX);
		fprintf(file, "%s\n", entry->d_name);
		index++;
	}

	closedir(dir);
	fclose(file);

	// Open the file for editing with nvim
	system("$EDITOR " TEMP_FILE_PATH);

	file = fopen(TEMP_FILE_PATH, "r");
	if (!file) {
		perror("Failed to reopen temp file for reading");
		free(filePairs);
		return EXIT_FAILURE;
	}

	// Read new names from file
	index       = 0;
	int renamed = 0;
	while (fgets(filePairs[index].newName, PATH_MAX, file) != NULL &&
	       index < fileStats.count) {
		// Strip newline
		filePairs[index].newName[strcspn(filePairs[index].newName, "\n")] = '\0';

		if (!isDotOrDotDot(filePairs[index].newName)) {
			if (strcmp(filePairs[index].currentName, filePairs[index].newName) != 0) {
				rename(filePairs[index].currentName, filePairs[index].newName);
				renamed++;
			}
		}
		index++;
	}

	printf("Renamed total %d\n", renamed);

	fclose(file);
	free(filePairs);

	return EXIT_SUCCESS;
}

maxPair countFilesAndMaxNameLen(const char *directoryPath) {
	DIR *dir = opendir(directoryPath);
	if (!dir) {
		perror("Failed to open directory in counter");
		return (maxPair) { 0, 0 };
	}

	struct dirent *entry;
	uint64_t count     = 0;
	uint64_t maxLength = 0;

	while ((entry = readdir(dir)) != NULL) {
		if (isDotOrDotDot(entry->d_name)) continue;

		size_t nameLen = strlen(entry->d_name);
		if (nameLen > maxLength) maxLength = nameLen;
		count++;
	}

	closedir(dir);
	return (maxPair) { maxLength, count };
}

int isDotOrDotDot(const char *name) {
	return (strcmp(name, ".") == 0 || strcmp(name, "..") == 0);
}
