# cgcmake
CMake modules for common applications related to computer graphics


Maya CMakeLists.txt
------------
    cmake_minimum_required(VERSION 2.6)
    project(sampleplugin)

    set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/modules)

    set(SOURCE_FILES "pluginMain.cpp"
        "sampleCmd.cpp" "sampleCmd.h"
    )

    find_package(Maya REQUIRED)

    include_directories(${MAYA_INCLUDE_DIR})
    link_directories(${MAYA_LIBRARY_DIR})
    add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
    target_link_libraries(${PROJECT_NAME} ${MAYA_LIBRARIES})

    MAYA_WRAP_CPP(${PROJECT_NAME})


From Command Line
-----------------
    # CMake 2.8.x
    cmake -G "Visual Studio 11 Win64" -DMAYA_VERSION=2015 ../
    cmake --build . --config Release

    # CMake 3.x
    cmake -G "Visual Studio 11 2012" -A x64 -DMAYA_VERSION=2015../
    cmake --build . --config Release
