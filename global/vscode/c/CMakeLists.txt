cmake_minimum_required(VERSION 3.31)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  HOMEPAGE_URL "https://github.com/pritam12426/"
  LANGUAGES C # Changed from CXX to C since your files are .c
)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/src/CmakeConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/CmakeConfig.h)
add_compile_options(-include "${CMAKE_CURRENT_BINARY_DIR}/CmakeConfig.h")

#### C Standard Settings ####
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

#### Setting the conditional variable ####
option(BUILD_TESTING "Enable unit testing" OFF)

#### Source Files ####
file(
  GLOB SRC_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/src/functions.c
) # Includes all .c files

#### Dependencies ####
# find_package(<X> REQUIRED)
# pkg_check_modules(GSL REQUIRED gsl)

#### Main Executable ####
add_executable(${PROJECT_NAME}
  ${SRC_FILES}
  "./src/main.c"
)

target_link_libraries(${PROJECT_NAME} PRIVATE
  # ${GSL_LIBRARIES}
  # ${GSL_LDFLAGS}
)

target_include_directories(${PROJECT_NAME} PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/src
  ${CMAKE_CURRENT_BINARY_DIR}
  # ${GSL_INCLUDE_DIRS}
)


#### Unit Tests ####
if(BUILD_TESTING)
  enable_testing()
  # add_subdirectory(tests)
  find_package(GTest REQUIRED)
  # find_package(Catch2 REQUIRED)

  set(TEST_BIN_NAME unitTests)

  set(TEST_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/test/main.cpp
  )

  add_executable(${TEST_BIN_NAME} ${TEST_SRC})
  target_link_libraries(${TEST_BIN_NAME} PRIVATE GTest::GTest)
  # target_link_libraries(${TEST_BIN_NAME} PRIVATE Catch2::Catch2WithMain)
  target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/src)
  target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/test)
  target_include_directories(${TEST_BIN_NAME} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
  add_test(NAME ${TEST_BIN_NAME} COMMAND ${TEST_BIN_NAME} "<args>")
endif()
