cmake_minimum_required(VERSION 3.31)

project(
  "main"
  VERSION 0.1.0
  DESCRIPTION "Small Project"
  LANGUAGES CXX
)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(SRC src/main.cpp)

# Add the main project
add_executable(${PROJECT_NAME} ${SRC})
