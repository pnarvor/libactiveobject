
add_executable( active_object_test
              active_idle_test.cpp )

link_directories( ${CONAN_LIB_DIRS} )

target_link_libraries( active_object_test
          ${CONAN_LIBS}
          active_object )

# Don't use ctest, instead just execture the Google test binaries
add_custom_target( unit_test
                    COMMAND ./active_object_test
                    WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/bin/
                    DEPENDS active_object_test )
