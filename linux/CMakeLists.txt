cmake_minimum_required(VERSION 3.13)
project(baimai_music LANGUAGES CXX)

set(BINARY_NAME "baimai_music")
cmake_policy(SET CMP0063 NEW)

set(CMAKE_INSTALL_PREFIX "${CMAKE_BINARY_DIR}/install")
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Prevent overriding the parent project's compiler/linker settings
set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

# Fetch the Flutter toolchain file
get_filename_component(FLUTTER_MANAGED_DIR
  "${CMAKE_CURRENT_SOURCE_DIR}/../flutter" ABSOLUTE)

include(${FLUTTER_MANAGED_DIR}/generated_plugins.cmake)

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

add_subdirectory(${FLUTTER_MANAGED_DIR} flutter)
add_subdirectory("runner")

# Generated plugin build rules, which manage building the plugins and adding
# them to the application.
add_dependencies(${BINARY_NAME} flutter_assemble)
