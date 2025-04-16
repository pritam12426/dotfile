#include <iostream>
#include "functions.hpp"

int main(int argc, char *argv[]) {
	std::cout << PROJECT_NAME << '\n';
	std::cout << PROJECT_VERSION << '\n';
	int a = Fun::add(2, 2);
	std::cout << a << '\n';
	return 0;
}
