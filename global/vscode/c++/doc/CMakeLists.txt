cmake_minimum_required(VERSION 4.0.0)

find_package(Doxygen REQUIRED)

set(DOXYFILE_IN ${CMAKE_CURRENT_LIST_DIR}/Doxyfile.in)
set(DOXYFILE ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile)
configure_file(${DOXYFILE_IN} ${DOXYFILE} @ONLY)

add_custom_target(doc
  COMMAND ${DOXYGEN_EXECUTABLE} ${DOXYFILE}
  WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
  COMMENT "Generating API documentation with Doxygen"
  VERBATIM
)
