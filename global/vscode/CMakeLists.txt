cmake_minimum_required(VERSION 3.31)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  HOMEPAGE_URL ""
  LANGUAGES CXX
)


#### Set C++ standard ####
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)


#### Set variables ####
set(SRC "src/main.cpp")
set(TES_SRC "test/test.cpp")
set(TEST_BIN_NAME "unitTests")


#### Finding package ####
# https://cmake.org/cmake/help/latest/command/find_package.html
message(CHECK_START "Finding X...")
find_package(GTest X)
message(CHECK_PASS "Found X")
message(STATUS "X_include_dirs -I ${X_INCLUDE_DIRS}")
message(STATUS "X_include_dir ${X_INCLUDE_DIR}")
message(STATUS "X_libraries ${X_LIBRARIES}")


#### Add the main project ####
add_executable(${PROJECT_NAME} ${SRC})
target_link_libraries(${PROJECT_NAME})


#### Add the test executable ####
enable_testing()
find_package(GTest REQUIRED)
add_executable(${TEST_EXE_NAME} ${TES_SRC})
target_link_libraries(${TEST_EXE_NAME} PRIVATE GTest::GTest)
add_test(NAME ${TEST_BIN_NAME} COMMAND ${TEST_BIN_NAME} [<arg>...])
