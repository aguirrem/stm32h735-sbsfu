cmake_minimum_required(VERSION 3.16)
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchain.cmake")

# Force CMake to use the cross compiler.
set(CMAKE_CROSSCOMPILING TRUE)

set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY") # Add this line
# Set your project name
project(STM32H735_Project C CXX ASM)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Specify the cross compiler
set(CMAKE_C_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-gcc)

# where is the target environment
set(CMAKE_FIND_ROOT_PATH /opt/ST/STM32CubeCLT/GNU-tools-for-STM32)

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# For libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE)