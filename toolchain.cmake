set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# specify the cross compiler
set(CMAKE_C_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-g++)

# where is the target environment
set(CMAKE_FIND_ROOT_PATH /opt/ST/STM32CubeCLT/GNU-tools-for-STM32)

# search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
