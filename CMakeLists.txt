cmake_minimum_required(VERSION 2.8.7)
project(libactive_object)
include(ExternalProject)

# set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR})
# set(RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

find_package(Boost COMPONENTS thread filesystem system REQUIRED)


## C++ flags applied to all builds
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

## Set global include paths
set( LIBACTIVE_OBJECT_INCLUDE_DIRS
	${CONAN_INCLUDE_DIRS}
  ${CMAKE_SOURCE_DIR}/include )
include_directories( ${LIBACTIVE_OBJECT_INCLUDE_DIRS} )

# if( APPLE )
# 	SET(CMAKE_INSTALL_RPATH "@executable_path/lib")
# 	set (MACOSX_RPATH ON)
# endif()

add_subdirectory("lib/")

option( BUILD_UNIT_TESTS "Build unit tests" OFF )
if( BUILD_UNIT_TESTS )
  ## Build a local copy of gtest (as per the GTest FAQ)
  #include( ${CMAKE_SOURCE_DIR}/cmake/BuildGTestLibraries.cmake )

  add_subdirectory( test/unit/ )
endif()

add_custom_target( deps DEPENDS ${EXTERNAL_PROJECTS} )
