cmake_minimum_required(VERSION 3.13)
project(runner LANGUAGES CXX)

set(BINARY_NAME "baimai_music")

cmake_policy(SET CMP0063 NEW)

set(CMAKE_LINUX_RPATH "$ORIGIN/lib")

find_package(PkgConfig REQUIRED)
pkg_check_modules(GTK3 REQUIRED gtk+-3.0)

add_executable(${BINARY_NAME}
  "main.cc"
  "my_application.cc"
  "${FLUTTER_MANAGED_DIR}/generated_plugin_registrant.cc"
)

apply_standard_settings(${BINARY_NAME})
target_compile_options(${BINARY_NAME} PRIVATE -Wall -Werror)
target_link_libraries(${BINARY_NAME} PRIVATE flutter)
target_link_libraries(${BINARY_NAME} PRIVATE ${GTK3_LIBRARIES})
target_include_directories(${BINARY_NAME} PRIVATE
  "${CMAKE_SOURCE_DIR}"
  "${FLUTTER_MANAGED_DIR}"
)
install(TARGETS ${BINARY_NAME} RUNTIME DESTINATION "${CMAKE_INSTALL_PREFIX}")
install(FILES "${FLUTTER_ICU_DATA_FILE}" DESTINATION "${CMAKE_INSTALL_PREFIX}/data")
install(FILES "${FLUTTER_LIBRARY}" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
foreach(bundled_library ${PLUGIN_BUNDLED_LIBRARIES})
  install(FILES "${bundled_library}" DESTINATION "${CMAKE_INSTALL_PREFIX}/lib")
endforeach(bundled_library)
install(CODE "
  file(GLOB_RECURSE FLUTTER_PLUGIN_LIBS
    \"${CMAKE_INSTALL_PREFIX}/lib/*.so\")
  foreach(plugin_lib \${FLUTTER_PLUGIN_LIBS})
    get_filename_component(plugin_lib_name \${plugin_lib} NAME)
  endforeach()
")
install(DIRECTORY "${CMAKE_INSTALL_PREFIX}/../bundle/" DESTINATION "${CMAKE_INSTALL_PREFIX}/data/flutter_assets")
