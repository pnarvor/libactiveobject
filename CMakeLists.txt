cmake_minimum_required(VERSION 3.10)
project(active_object VERSION 0.1)

find_package(Boost COMPONENTS thread filesystem system REQUIRED)

list(APPEND active_object_headers
    include/active_object/active.h
    include/active_object/bounded_shared_queue.h
    include/active_object/shared_queue.h
)

add_library(active_object SHARED
    lib/active.cpp
    lib/active_idle.cpp
)
set_target_properties(active_object PROPERTIES
    PUBLIC_HEADER "${active_object_headers}"
)
target_compile_features(active_object PUBLIC cxx_std_11)
target_include_directories(active_object PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
)
target_link_libraries(active_object PUBLIC
    Boost::system
)

include(${CMAKE_CURRENT_SOURCE_DIR}/cmake/narval_installation.cmake)
narval_install_target(active_object)


