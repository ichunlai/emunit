# FindNEWLIB.cmake
# This module finds the NEWLIB library

# Find the NEWLIB include directory
find_path(NEWLIB_INCLUDE_DIR
    NAMES newlib.h
    PATHS
        ${CMAKE_SOURCE_DIR}/lib/newlib/src/newlib/libc/include
        /usr/include
        /usr/local/include
    DOC "NEWLIB include directory"
)

# Find the NEWLIB library
find_library(NEWLIB_LIBRARY
    NAMES newlib
    PATHS
        ${CMAKE_SOURCE_DIR}/lib/newlib/build
        /usr/lib
        /usr/local/lib
    DOC "NEWLIB library"
)

# Handle standard arguments
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(NEWLIB
    DEFAULT_MSG
    NEWLIB_INCLUDE_DIR
)

# Create imported target
if(NEWLIB_FOUND AND NOT TARGET NEWLIB::NEWLIB)
    add_library(NEWLIB::NEWLIB UNKNOWN IMPORTED)
    set_target_properties(NEWLIB::NEWLIB PROPERTIES
        IMPORTED_LOCATION "${NEWLIB_LIBRARY}"
        INTERFACE_INCLUDE_DIRECTORIES "${NEWLIB_INCLUDE_DIR}"
    )
endif()

# Mark as advanced
mark_as_advanced(NEWLIB_INCLUDE_DIR NEWLIB_LIBRARY)