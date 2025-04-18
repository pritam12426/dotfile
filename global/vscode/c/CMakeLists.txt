cmake_minimum_required(VERSION 4.0.0)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  HOMEPAGE_URL "https://github.com/pritam12426/"
  LANGUAGES C
)

configure_file(${CMAKE_CURRENT_LIST_DIR}/src/CmakeConfig.h.in ${CMAKE_CURRENT_BINARY_DIR}/CmakeConfig.h)
add_compile_options(-include "${CMAKE_CURRENT_BINARY_DIR}/CmakeConfig.h")
# https://stackoverflow.com/questions/30027016/cannot-export-cmake-project-version-major-because-it-equals-zero

#### C++ Standard Settings ####
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(MAIN_BINARY "main")

#### Source Files ####
file(GLOB
  SRC_FILES
  "${CMAKE_CURRENT_LIST_DIR}/src/functions.c"
)

#### Dependencies ####
# find_package(PkgConfig REQUIRED)
# pkg_check_modules(LIBXML REQUIRED libxml++-5.0)

#### Main Executable ####
add_executable(${MAIN_BINARY}
  ${SRC_FILES}
  "${CMAKE_CURRENT_LIST_DIR}/src/main.c"
)

target_link_libraries(${MAIN_BINARY} PRIVATE
  # ${LIBXML_LDFLAGS}
)

target_include_directories(${MAIN_BINARY} PRIVATE
  ${PROJECT_SOURCE_DIR}/src
  ${CMAKE_CURRENT_BINARY_DIR}
  # ${LIBXML_INCLUDE_DIRS}
)

add_custom_target(
  run
  COMMAND ./${MAIN_BINARY}
  COMMENT "Runing ${MAIN_BINARY}"
  DEPENDS ${MAIN_BINARY}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

#### Setting the conditional variable ####
option(BUILD_TESTING "Enable unit testing" OFF)
option(BUILD_DOC "Generate doc for the project" OFF)

#### Unit Tests ####
if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(tests)
endif()

#### Bulding doc ####
if(BUILD_DOC)
  add_subdirectory(doc)
endif()
