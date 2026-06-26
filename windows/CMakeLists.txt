cmake_minimum_required(VERSION 3.14)
project(baimai_music LANGUAGES CXX)

set(BINARY_NAME "baimai_music")

cmake_policy(SET CMP0063 NEW)

set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

get_filename_component(FLUTTER_MANAGED_DIR
  "${CMAKE_CURRENT_SOURCE_DIR}/../flutter" ABSOLUTE)

include(${FLUTTER_MANAGED_DIR}/generated_plugins.cmake)

add_subdirectory(${FLUTTER_MANAGED_DIR} flutter)
add_subdirectory("runner")

install(CODE "
  file(GLOB_RECURSE FLUTTER_PLUGIN_LIBS
    \"\${CMAKE_INSTALL_PREFIX}/\")
")

add_dependencies(${BINARY_NAME} flutter_assemble)
