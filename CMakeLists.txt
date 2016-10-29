cmake_minimum_required(VERSION 2.8.7)
project(libactive_object)
include(ExternalProject)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR})
set(RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
# find_package(Boost COMPONENTS thread filesystem system REQUIRED)
# find_package(Eigen3 REQUIRED)
#
# find_package(TCLAP REQUIRED )
# find_package(ZLIB REQUIRED)
#
# include( ${PROJECT_SOURCE_DIR}/cmake/BuildG3Log.cmake )
#
# set( EXTERNAL_PROJECTS g3log )
# ## Command used to build the external projects
# set( EXTERNAL_PROJECT_PARALLELISM 4 CACHE STRING "Level of parallelism when making ExternalProjects" )
# set( EXTERNAL_PROJECT_MAKE_COMMAND "make" )
# if( EXTERNAL_PROJECT_PARALLELISM GREATER 0 )
# 	message( "Building ExternalProjects in Parallel, to disable set EXTERNAL_PROJECT_PARALLELISM to 0")
# 	set( EXTERNAL_PROJECT_MAKE_COMMAND make -j${EXTERNAL_PROJECT_PARALLELISM} )
# endif()

## C++ flags applied to all builds
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

if(APPLE)
	set( CMAKE_MACOSX_RPATH OFF )
endif()

## Set global include paths
set( LIBACTIVE_OBJECT_INCLUDE_DIRS
  ${CMAKE_SOURCE_DIR}/include )
include_directories( ${LIBACTIVE_OBJECT_INCLUDE_DIRS} )

add_subdirectory("lib/")

option( BUILD_UNIT_TESTS "Build unit tests" ON )
if( BUILD_UNIT_TESTS )
  ## Build a local copy of gtest (as per the GTest FAQ)
  include( ${CMAKE_SOURCE_DIR}/cmake/BuildGTestLibraries.cmake )

  add_subdirectory( test/unit/ )
endif()

add_custom_target( deps DEPENDS ${EXTERNAL_PROJECTS} )
