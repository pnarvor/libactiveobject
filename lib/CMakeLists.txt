
include_directories(
  ${Boost_INCLUDE_DIR}
)

# build shared library.
fips_begin_module(activeobject)
  fips_files(active.cpp active_idle.cpp)
  fips_libs( ${Boost_LIBRARIES} )
fips_end_module()
