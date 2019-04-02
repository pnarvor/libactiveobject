cmake_minimum_required(VERSION 2.8.3)
project(active_object)

# 	# A few things which are otherwise handled by Conan
#  if( APPLE )
#     SET(CMAKE_INSTALL_RPATH "@executable_path/lib")
#     set (MACOSX_RPATH ON)
#   endif()
#
# 	set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
# 	set(RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
# endif()
#
#
# find_package(Threads)

find_package(catkin REQUIRED)

catkin_package(
        INCLUDE_DIRS include
        LIBRARIES activeobject
)

## C++ flags applied to all builds
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

include_directories(
  include
)

## Build activeobject
add_library(activeobject src/active.cpp src/active_idle.cpp)
target_link_libraries(activeobject ${catkin_LIBRARIES})
install(DIRECTORY include/${PROJECT_NAME}/
        DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})

install(TARGETS activeobject
        ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION})