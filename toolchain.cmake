set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    # specify the cross compiler
    set(CMAKE_C_COMPILER /opt/st/stm32cubeide_1.12.0/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.linux64_1.0.200.202301161003/tools/bin/arm-none-eabi-gcc)
    set(CMAKE_CXX_COMPILER /opt/st/stm32cubeide_1.12.0/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.linux64_1.0.200.202301161003/tools/bin/arm-none-eabi-g++)
    # where is the target environment
    set(CMAKE_FIND_ROOT_PATH /opt/st/stm32cubeide_1.12.0/plugins/com.st.stm32cube.ide.mcu.externaltools.gnu-tools-for-stm32.10.3-2021.10.linux64_1.0.200.202301161003/tools/)

endif()


# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
