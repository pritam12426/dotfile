cmake_minimum_required(VERSION 3.31)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  HOMEPAGE_URL "https://github.com/pritam12426/<>"
  LANGUAGES CXX
)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/src/CmakeConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/CmakeConfig.h)
add_compile_options(-include "${CMAKE_CURRENT_BINARY_DIR}/CmakeConfig.h")
# https://stackoverflow.com/questions/30027016/cannot-export-cmake-project-version-major-because-it-equals-zero

#### C++ Standard Settings ####
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#### Setting the conditional variable ####
option(BUILD_TESTING "Enable unit testing" OFF)

#### Source Files ####
file(GLOB
  SRC_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp
)

#### Dependencies ####
# find_package(<X> REQUIRED)
# include(${<X>_USE_FILE})
# target_link_libraries(${PROJECT_NAME} PRIVATE ${<X>_LIBRARIES})

#### Main Executable ####
add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE ${SRC_FILES})
# target_link_libraries(${PROJECT_NAME} PRIVATE GTest::GTest)
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})


#### Unit Tests ####
if(BUILD_TESTING)
  enable_testing()
  # add_subdirectory(tests)
  find_package(GTest REQUIRED)

  set(TEST_BIN_NAME unitTests)

  set(TEST_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp
  )

  add_executable(${TEST_BIN_NAME} ${TEST_SRC})
  target_link_libraries(${TEST_BIN_NAME} PRIVATE GTest::GTest)
  target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
  target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/test)
  target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
  add_test(NAME ${TEST_BIN_NAME} COMMAND ${TEST_BIN_NAME} "<args>")
endif()
