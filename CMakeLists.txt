cmake_minimum_required(VERSION 3.5)
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.19.167.tar.gz"
    SHA1 "244a13718ea2e6c0c8998d15559c7e459f615708"
)

project(libactive_object)

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

hunter_add_package(Boost COMPONENTS thread filesystem system )
find_package(Boost COMPONENTS thread filesystem system)

## C++ flags applied to all builds
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

## Set global include paths
set( LIBACTIVE_OBJECT_INCLUDE_DIRS
  ${CMAKE_SOURCE_DIR}/include )
include_directories( ${LIBACTIVE_OBJECT_INCLUDE_DIRS} )

add_subdirectory("lib/")

option( BUILD_UNIT_TESTS "Build unit tests" OFF )
if( BUILD_UNIT_TESTS )
  hunter_add_package( GTest )
  find_package(GTest CONFIG REQUIRED )

  add_subdirectory( test/unit/ )
endif()
