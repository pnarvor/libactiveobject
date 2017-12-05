if( NOT FIPS_IMPORT )
  cmake_minimum_required(VERSION 3.5)

  get_filename_component(FIPS_ROOT_DIR "../fips" ABSOLUTE)
  include("${FIPS_ROOT_DIR}/cmake/fips.cmake")

  fips_setup(PROJECT libactive_object)
endif()

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

find_package(Boost COMPONENTS thread filesystem system)

## C++ flags applied to all builds
set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

## Set global include paths
set( LIBACTIVE_OBJECT_INCLUDE_DIRS ${CMAKE_SOURCE_DIR}/include )
include_directories( ${LIBACTIVE_OBJECT_INCLUDE_DIRS} )

fips_add_subdirectory("lib/")

fips_add_subdirectory("test/unit/")

if( NOT FIPS_IMPORT )
  fips_finish()
endif()
