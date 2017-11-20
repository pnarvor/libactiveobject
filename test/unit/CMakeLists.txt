
add_executable( active_object_test
                        active_idle_test.cpp )

target_link_libraries( active_object_test
                        active_object GTest::main )

# Don't use ctest, instead just execture the Google test binaries
add_custom_target( unit_test
                    COMMAND ./active_object_test
                    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/test/unit/
                    DEPENDS active_object_test )
