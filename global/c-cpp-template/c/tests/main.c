#include <unity/unity.h>

#include "../src/functions.h"
#include "CmakeConfig.h"

void setUp(void) {}     // Required by Unity
void tearDown(void) {}  // Required by Unity

void test_add(void) {
	TEST_ASSERT_EQUAL(5, add(2, 3));
	TEST_ASSERT_EQUAL(-1, add(2, -3));
	TEST_ASSERT_EQUAL(0, add(0, 0));
}

int main(void) {
	UNITY_BEGIN();
	RUN_TEST(test_add);
	return UNITY_END();
}
