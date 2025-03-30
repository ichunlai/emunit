# Source directory CMakeLists.txt

# Add main executable
add_executable(emunit_app
    main.c
)

# Set output name
set_target_properties(emunit_app PROPERTIES OUTPUT_NAME "emunit")

# NEWLIB configuration
if(USE_NEWLIB AND NOT TARGET_ARCH STREQUAL "x86")
    include_directories(${NEWLIB_INSTALL_DIR}/arm-none-eabi/include)
    link_directories(${NEWLIB_INSTALL_DIR}/arm-none-eabi/lib)
endif()

# Install
install(TARGETS emunit_app DESTINATION bin)