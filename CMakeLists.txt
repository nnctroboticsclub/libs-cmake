cmake_minimum_required(VERSION 3.22)
project(libs-cmake)

install(
  FILES
    cmake/Findcan_servo.cmake
    cmake/FindFutaba_Puropo.cmake
    cmake/Findikako_rohm_md.cmake
    cmake/FindikakoMDC.cmake
    cmake/FindIkakoRobomas.cmake
    cmake/FindikarashiCAN_mk2.cmake
    cmake/Findim920_rs.cmake
    cmake/Findmbed-ce.cmake
    cmake/FindMotorController.cmake
    cmake/FindPS4_RX.cmake
    cmake/Findsrobo_base.cmake
    cmake/MbedCE-Toolchain.cmake
    cmake/MbedCE.cmake
    cmake/Findfmt.cmake
    cmake/Findtcb_span.cmake
    cmake/TargetDumper.cmake
    cmake/DependencyFinder.cmake
    cmake/GccArmToolchain.cmake
    cmake/TargetTransformer.cmake
    cmake/Findcereal.cmake
  DESTINATION share/cmake
)

