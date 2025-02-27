cmake_minimum_required(VERSION 3.31)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  LANGUAGES CXX
)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/src/CmakeConfig.h CmakeConfig.h)
# https://stackoverflow.com/questions/30027016/cannot-export-cmake-project-version-major-because-it-equals-zero

#### C++ Standard Settings ####
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#### Setting the conditional variable ####
# option(GET_THE_NAME "<help_text>" ON)

#### Source Files ####
set(SRC_FILES
  src/main.cpp
  # src/person.cpp
)

#### Dependencies ####
find_package(GTest REQUIRED)

#### Main Executable ####
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE ${SRC_FILES})
# target_link_libraries(${PROJECT_NAME} PRIVATE GTest::GTest)
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)

#### Unit Tests ####
# set(TEST_SRC test/main.cpp)
# set(TEST_BIN_NAME unitTests)

# enable_testing()
# add_executable(${TEST_BIN_NAME} ${TEST_SRC})
# target_link_libraries(${TEST_BIN_NAME} PRIVATE GTest::GTest)
# target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
# add_test(NAME ${TEST_BIN_NAME} COMMAND ${TEST_BIN_NAME} "<args>")
