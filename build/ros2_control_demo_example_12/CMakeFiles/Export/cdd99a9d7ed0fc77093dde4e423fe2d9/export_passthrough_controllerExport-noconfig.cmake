#----------------------------------------------------------------
# Generated CMake target import file.
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "ros2_control_demo_example_12::passthrough_controller" for configuration ""
set_property(TARGET ros2_control_demo_example_12::passthrough_controller APPEND PROPERTY IMPORTED_CONFIGURATIONS NOCONFIG)
set_target_properties(ros2_control_demo_example_12::passthrough_controller PROPERTIES
  IMPORTED_LOCATION_NOCONFIG "${_IMPORT_PREFIX}/lib/libpassthrough_controller.so"
  IMPORTED_SONAME_NOCONFIG "libpassthrough_controller.so"
  )

list(APPEND _cmake_import_check_targets ros2_control_demo_example_12::passthrough_controller )
list(APPEND _cmake_import_check_files_for_ros2_control_demo_example_12::passthrough_controller "${_IMPORT_PREFIX}/lib/libpassthrough_controller.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
