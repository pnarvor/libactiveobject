cmake_minimum_required(VERSION 2.8.7)
project(libactive_object)
include(ExternalProject)

option (USE_CONAN  "Use the Conan packaging system" OFF)
if(USE_CONAN)
  include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
  conan_basic_setup()
else()
	# A few things which are otherwise handled by Conan
 if( APPLE )
    SET(CMAKE_INSTALL_RPATH "@executable_path/lib")
    set (MACOSX_RPATH ON)
  endif()

	set(EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin)
	set(RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
endif()


find_package(Boost COMPONENTS thread filesystem system REQUIRED)

## C++ flags applied to all builds
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

## Set global include paths
set( LIBACTIVE_OBJECT_INCLUDE_DIRS
  ${CONAN_INCLUDE_DIRS}
  ${CMAKE_SOURCE_DIR}/include )
include_directories( ${LIBACTIVE_OBJECT_INCLUDE_DIRS} )

add_subdirectory("lib/")

option( BUILD_UNIT_TESTS "Build unit tests" OFF )
if( BUILD_UNIT_TESTS )
  ## Build a local copy of gtest (as per the GTest FAQ)
  if( NOT USE_CONAN )
    include( ${CMAKE_SOURCE_DIR}/cmake/BuildGTestLibraries.cmake )
    include_directories( ${GTEST_INCLUDE_DIRS} )
    set( CONAN_LIB_DIRS ${GTEST_LIBRARY_DIR} )
    set( CONAN_LIBS ${GTEST_BOTH_LIBRARIES} )
  endif()

  add_subdirectory( test/unit/ )
endif()

add_custom_target( deps DEPENDS ${EXTERNAL_PROJECTS} )
