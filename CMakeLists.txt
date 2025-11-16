cmake_minimum_required(VERSION 3.22)
project(libs-cmake)

install(
  FILES
    cmake/TargetDumper.cmake
    cmake/DependencyFinder.cmake
    cmake/TargetTransformer.cmake
  DESTINATION lib/cmake
)

install(
  FILES
    cmake-libs/FindFutaba_Puropo.cmake
    cmake-libs/Findfmt.cmake
    cmake-libs/Findsrobo_base.cmake
    cmake-libs/FindPS4_RX.cmake
    cmake-libs/Findikako_rohm_md.cmake
    cmake-libs/Findtcb_span.cmake
    cmake-libs/Findcan_servo.cmake
    cmake-libs/Findim920_rs.cmake
    cmake-libs/Findcereal.cmake
  DESTINATION lib/cmake
)
