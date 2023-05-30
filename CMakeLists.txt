cmake_minimum_required(VERSION 3.16)
set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/toolchain.cmake")

# Force CMake to use the cross compiler.
set(CMAKE_CROSSCOMPILING TRUE)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY") # Add this line
# Set your project name
project(STM32H735_Project C CXX ASM)

# set(CMAKE_SYSTEM_NAME Generic)
# set(CMAKE_SYSTEM_PROCESSOR arm)

# Specify the cross compiler
# set(CMAKE_C_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-gcc)
# set(CMAKE_CXX_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-g++)
# set(CMAKE_ASM_COMPILER /opt/ST/STM32CubeCLT/GNU-tools-for-STM32/bin/arm-none-eabi-gcc)

# where is the target environment
set(CMAKE_FIND_ROOT_PATH /opt/ST/STM32CubeCLT/GNU-tools-for-STM32)

# Search for programs in the build host directories
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# For libraries and headers in the target directories
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE)



# Add the directory with the CMSIS and HAL includes
include_directories(
  ${CMAKE_SOURCE_DIR}/Inc
  ${CMAKE_SOURCE_DIR}/Core/Inc
  ${CMAKE_SOURCE_DIR}/Drivers/STM32H7xx_HAL_Driver/Inc
  ${CMAKE_SOURCE_DIR}/Drivers/STM32H7xx_HAL_Driver/Inc/Legacy
  ${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Device/ST/STM32H7xx/Include
  ${CMAKE_SOURCE_DIR}/Drivers/CMSIS/Include
  ${CMAKE_SOURCE_DIR}/Drivers/BSP
  
  #SBSFU headers
  ${CMAKE_SOURCE_DIR}/1_ImageSBSFU/Core/Inc
  ${CMAKE_SOURCE_DIR}/1_ImageSBSFU/Core/Inc
  ${CMAKE_SOURCE_DIR}/1_ImageSBSFU/SBSFU/App 

  #SBSFU Target H735
  ${CMAKE_SOURCE_DIR}/src/Target
  #SECoreBin Headers
  ${CMAKE_SOURCE_DIR}/../stm32h735-secorebin/1_Image_SECoreBin/Inc
  

  ${CMAKE_SOURCE_DIR}/../Middlewares/ST/STM32_Secure_Engine/Core
  #Linker Common
  ${CMAKE_SOURCE_DIR}/../Linker_Common/STM32CubeIDE
)




# Prepend the source directory to the header file names
list(TRANSFORM SPECIFIC_HEADER_FILENAMES PREPEND ${CMAKE_SOURCE_DIR}/)


message("Source files:")
foreach(HEADER ${SPECIFIC_HEADER_FILENAMES})
    message("${HEADER}")
endforeach()


# Add the source files
file(GLOB_RECURSE SOURCES 
  "src/main.c"
  "src/stm32h7xx_hal_msp.c"
  "src/stm32h7xx_it.c"
  "src/sfu_secorebin_Inc.c"
  "src/Target/sfu_low_level.c"
  "src/Target/sfu_low_level_flash.c"
  "src/Target/sfu_low_level_security.c"
  "src/Target/sfu_low_level_flash.c"
  "src/Target/sfu_low_level_flash_int.c"
  "src/Target/sfu_low_level_flash_ext.c"
  #"src/syscalls.c"
  #"src/sysmem.c"
  "src/system_stm32h7xx.c"
  #Drivers 
  "Drivers/STM32H7xx_HAL_Driver/Src/*.c" 
  #Board Support Package
  "Drivers/BSP/*.c"
  #sbsfu files
  "1_ImageSBSFU/STM32CubeIDE/Application/Core/syscalls.c"
  "1_ImageSBSFU/SBSFU/App/sfu_boot.c"
  "1_ImageSBSFU/SBSFU/App/sfu_mpu_isolation.c"
  "1_ImageSBSFU/SBSFU/App/sfu_com_trace.c"
  "1_ImageSBSFU/SBSFU/App/sfu_loader.c"
  "1_ImageSBSFU/SBSFU/App/sfu_error.c"
  "1_ImageSBSFU/SBSFU/App/sfu_fwimg_common.c"
  "1_ImageSBSFU/SBSFU/App/sfu_com_loader.c"
  "1_ImageSBSFU/SBSFU/App/sfu_new_image.c"
  "../Middlewares/ST/STM32_Secure_Engine/Core/se_interface_bootloader.c"
  "../Middlewares/ST/STM32_Secure_Engine/Core/se_interface_common.c"
  
)



set(EXTRA_SOURCES

)

list(APPEND SOURCES ${EXTRA_SOURCES})

message("Source files:")
foreach(SOURCE ${SOURCES})
    message("${SOURCE}")
endforeach()

set(STARTUP_FILE "${CMAKE_SOURCE_DIR}/Startup/startup_stm32h735zgtx.s")

# Add executable
add_executable(${PROJECT_NAME}.elf ${SOURCES} ${STARTUP_FILE})


# Add preprocessor definitions
target_compile_definitions(${PROJECT_NAME}.elf PRIVATE
  DEBUG
  USE_HAL_DRIVER
  STM32H735xx
)

# Add compiler options
# target_compile_options(${PROJECT_NAME}.elf PRIVATE
#   -mcpu=cortex-m7
#   -mthumb
#   -mfloat-abi=hard
#   -mfpu=fpv5-d16
#   -O0
# )

target_compile_options(${PROJECT_NAME}.elf PRIVATE
  -mcpu=cortex-m7
  -std=gnu11
  -g3
  -DDEBUG
  -DUSE_HAL_DRIVER
  -DSTM32H735xx
  -O0
  -ffunction-sections
  -fdata-sections
  -Wall
  -fstack-usage
  -fcyclomatic-complexity
  --specs=nano.specs
  -mfpu=fpv5-d16
  -mfloat-abi=hard
  -mthumb
)
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mcpu=cortex-m7 -T${CMAKE_SOURCE_DIR}/STM32H735ZGTX_FLASH.ld --specs=nosys.specs -Wl,-Map=${PROJECT_NAME}.map -Wl,--gc-sections -static --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group -L${CMAKE_SOURCE_DIR}/../Linker_Common/STM32CubeIDE/")

#set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -mcpu=cortex-m7 -T${CMAKE_SOURCE_DIR}/STM32H735ZGTX_FLASH.ld --specs=nosys.specs -Wl,-Map=${PROJECT_NAME}.map -Wl,--gc-sections -static --specs=nano.specs -mfpu=fpv5-d16 -mfloat-abi=hard -mthumb -Wl,--start-group -lc -lm -Wl,--end-group")

# Generate HEX file
add_custom_command(TARGET ${PROJECT_NAME}.elf POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${PROJECT_NAME}.elf> ${PROJECT_NAME}.hex
    COMMENT "Generating HEX file"
)

# Create custom target to generate the HEX file
add_custom_target(${PROJECT_NAME}.hex_target DEPENDS ${PROJECT_NAME}.elf)
