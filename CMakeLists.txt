cmake_minimum_required(VERSION 2.8.3)
project(active_object)

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
add_library(activeobject lib/active.cpp lib/active_idle.cpp)
target_link_libraries(activeobject ${catkin_LIBRARIES})

install(DIRECTORY include/${PROJECT_NAME}/
        DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION})

install(TARGETS activeobject
        ARCHIVE DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        LIBRARY DESTINATION ${CATKIN_PACKAGE_LIB_DESTINATION}
        RUNTIME DESTINATION ${CATKIN_GLOBAL_BIN_DESTINATION})
