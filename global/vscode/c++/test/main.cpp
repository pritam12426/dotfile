#include <gtest/gtest.h>

// #include "../src/something.hpp"

TEST(FactorialTest, FactorialOfPositiveNos) {
  ASSERT_EQ(1, factorial(1));
}

int main(int argc, char **argv) {
  testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
