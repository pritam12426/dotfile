cmake_minimum_required(VERSION 4.0.0)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  HOMEPAGE_URL "https://github.com/pritam12426/"
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
  ${CMAKE_CURRENT_SOURCE_DIR}/src/functions.cpp
)

#### Dependencies ####
# find_package(<X> REQUIRED)
# pkg_check_modules(GSL REQUIRED gsl)

#### Main Executable ####
add_executable(${PROJECT_NAME}
  ${SRC_FILES}
  "./src/main.cpp"
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

add_custom_target(
  run
  COMMAND ./${PROJECT_NAME}
  COMMENT "Runing the ${PROJECT_NAME} Binary"
  DEPENDS ${PROJECT_NAME}
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
)

#### Unit Tests ####
if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()
