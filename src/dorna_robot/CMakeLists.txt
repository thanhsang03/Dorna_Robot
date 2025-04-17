cmake_minimum_required(VERSION 3.16)
project(dorna_robot LANGUAGES CXX) # C++ cho plugin phan cung
								   # Dat ten projetc

find_package(ros2_control_cmake REQUIRED) # cung cap Macro va ho tro build plugin  
set_compiler_options()
export_windows_symbols()

# find dependencies
set(THIS_PACKAGE_INCLUDE_DEPENDS  # package ros2 to build this project
  hardware_interface
  pluginlib
  rclcpp
  rclcpp_lifecycle
)

# Specify the required version of ros2_control
find_package(controller_manager 4.0.0)
# Handle the case where the required version is not found
if(NOT controller_manager_FOUND)
  message(FATAL_ERROR "ros2_control version 4.0.0 or higher is required. "
  "Are you using the correct branch of the ros2_control_demos repository?")
endif()
# Tim goi ros2 control va kiem tra phien ban

# find dependencies to build ros2 package
find_package(backward_ros REQUIRED)
find_package(ament_cmake REQUIRED)
foreach(Dependency IN ITEMS ${THIS_PACKAGE_INCLUDE_DEPENDS})
  find_package(${Dependency} REQUIRED)
endforeach()

## COMPILE
## Add hardware interface library
add_library(  # tao thu vien dong shared library cos ten la dorna_hardware_interface
  dorna_hardware_interface
  SHARED
  hardware/dorna_hardware_interface.cpp   #=> dung lam plugin cho ros2 control
)
# Cài đặt chuẩn biên dịch cho C++17
target_compile_features(dorna_hardware_interface PUBLIC cxx_std_17)
# Khai báo đường dẫn include header khi build và khi install
target_include_directories(dorna_hardware_interface PUBLIC
	$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/hardware/include>
	$<INSTALL_INTERFACE:include/ros2_control_hwI>
)
# Khai báo các gói phụ thuộc ROS 2 mà thư viện này cần
ament_target_dependencies(
  dorna_hardware_interface PUBLIC
  ${THIS_PACKAGE_INCLUDE_DEPENDS}
)

# Export hardware plugins
pluginlib_export_plugin_description_file(dorna_hardware_interface dorna_ros2_control_hwI_plugin.xml)

# INSTALL
## chỉ định các tệp và thư mục nào sẽ được cài đặt khi chạy colcon build --install
install(
  DIRECTORY hardware/include/
  DESTINATION include/ros2_control_hwI
)
install(
  DIRECTORY description/launch description/ros2_control description/urdf description/gazebo description/rviz meshes/
  DESTINATION share/dorna_robot
)
install(
  DIRECTORY bringup/launch bringup/config
  DESTINATION share/dorna_robot
)
install(TARGETS dorna_hardware_interface
  EXPORT export_dorna_hardware_interface
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

if(BUILD_TESTING)
  find_package(ament_cmake_pytest REQUIRED)

  #ament_add_pytest_test(example_9_urdf_xacro test/test_urdf_xacro.py)
  #ament_add_pytest_test(view_example_9_launch test/test_view_robot_launch.py)
  #ament_add_pytest_test(run_example_9_launch test/test_rrbot_launch.py)
  #ament_add_pytest_test(run_example_9_gazebo_launch test/test_rrbot_gazebo_launch.py)
endif()

## EXPORTS
ament_export_targets(export_dorna_hardware_interface HAS_LIBRARY_TARGET)
ament_export_dependencies(${THIS_PACKAGE_INCLUDE_DEPENDS})
ament_package()
