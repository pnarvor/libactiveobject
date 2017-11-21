
gtest_begin(activeobject)
	fips_files(
		active_idle_test.cpp
	)
	fips_deps(active_object)
gtest_end()

# Don't use ctest, instead just execture the Google test binaries
add_custom_target( unit_test
                    COMMAND ./active_object_test
                    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/test/unit/
                    DEPENDS active_object_test )
