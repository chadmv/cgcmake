# cgcmake
CMake modules for common applications related to computer graphics


Maya CMakeLists.txt
-------------------
    cmake_minimum_required(VERSION 3.1)
    project(sampleplugin)

    set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/modules)

    set(SOURCE_FILES "pluginMain.cpp"
        "sampleCmd.cpp" "sampleCmd.h"
    )

    find_package(Maya REQUIRED)

    add_library(sampleplugin SHARED ${SOURCE_FILES})
    target_link_libraries(sampleplugin PRIVATE Maya::Maya)
    target_include_directories(sampleplugin PRIVATE Maya::Maya)
    MAYA_PLUGIN(sampleplugin)


From Command Line
-----------------
    # CMake 3.x
    cmake -G "Visual Studio 14 2015 Win64" -DMAYA_VERSION=2018 ../
    cmake --build . --config Release

