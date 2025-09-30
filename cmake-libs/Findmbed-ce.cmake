include(FetchContent)

FetchContent_Populate(mbed-ce
  GIT_REPOSITORY https://github.com/mbed-ce/mbed-os.git
  GIT_SHALLOW 1
  SOURCE_DIR /usr/arm-none-eabi/src/mbed-ce/src
  BINARY_DIR ${CMAKE_BINARY_DIR}/3rd-party/mbed-ce/build
  SUBBUILD_DIR ${CMAKE_BINARY_DIR}/3rd-party/mbed-ce/subbuild
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(mbed-ce
  REQUIRED_VARS
    mbed-ce_SOURCE_DIR
)