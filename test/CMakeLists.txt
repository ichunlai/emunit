# Test directory CMakeLists.txt

# Include Unity framework
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/../lib/unity/src)

# Add Unity sources
set(UNITY_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/../lib/unity/src/unity.c
)

# Add test executable
add_executable(main_test
    test_main.c
    ${UNITY_SOURCES}
)

# Set output name
set_target_properties(main_test PROPERTIES OUTPUT_NAME "main_test")

# Link libraries
if(USE_NEWLIB AND NOT TARGET_ARCH STREQUAL "x86")
    target_link_libraries(main_test c m)
endif()

# Add test to CTest
add_test(NAME main_test COMMAND main_test)