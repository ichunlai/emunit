set(NEWLIB_BUILD_DIR ${CMAKE_BINARY_DIR}/newlib_build)
set(NEWLIB_INSTALL_DIR ${CMAKE_BINARY_DIR}/newlib_install)

# 執行 Newlib configure 並使用 Makefile 建置
add_custom_target(newlib_build ALL
    COMMAND ${NEWLIB_SRC_DIR}/configure --target=arm-none-eabi --prefix=${NEWLIB_INSTALL_DIR}
    COMMAND make -j$(nproc)
    COMMAND make install
    WORKING_DIRECTORY ${NEWLIB_BUILD_DIR}
)
# 設定 include 和 library 路徑
include_directories(${NEWLIB_INSTALL_DIR}/arm-none-eabi/include)
link_directories(${NEWLIB_INSTALL_DIR}/arm-none-eabi/lib)

# 建立可執行檔
# add_executable(my_project src/main.c)

# 確保 my_project 依賴於 newlib_build
# add_dependencies(my_project newlib_build)
# target_link_libraries(my_project m c nosys)