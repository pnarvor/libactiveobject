
find_package(Boost COMPONENTS thread filesystem system)

include_directories(
  ${Boost_INCLUDE_DIR}
)

# build shared library.
fips_begin_module(active_object)
  fips_files(active.cpp active_idle.cpp)
  fips_libs( ${Boost_LIBRARIES} )
fips_end_module()
