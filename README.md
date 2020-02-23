Originally forked from https://github.com/chadmv/cgcmake

# cgcmake
CMake modules for common applications related to computer graphics.

## Example
-------------------

Top level CMakeLists.txt
-------------------
    cmake_minimum_required(VERSION 3.14) # prefer newest version

    project(MayaPlugin-Top C CXX)

    # set this to whereever you placed FindMaya.cmake
    set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake/modules)

    ## import Maya package
    find_package(Maya REQUIRED)

    add_subdirectory(example-hello-world-cmd)
    add_subdirectory(plugin-main)

example-hello-world-cmd CMakeLists.txt
-------------------


    ## Sample hello world command

    project(HelloWorldCmd)

    add_library(${PROJECT_NAME} STATIC)

    target_include_directories(
        ${PROJECT_NAME} 
        PUBLIC 
        ${CMAKE_CURRENT_SOURCE_DIR}/include
    )

    target_sources(
        ${PROJECT_NAME}
        PRIVATE
        src/MSimple.h
        include/HelloworldCmd.h
        src/HelloworldCmd.cpp
    )

    target_link_libraries(
        ${PROJECT_NAME} 
        PUBLIC 
        Maya::Maya
    )

plugin-main CMakeLists.txt
-------------------

    ## Maya plugin entry

    project(SamplePlugins)

    # Maya plugin specific drop-in replacement for add_library command
    ADD_MAYA_PLUGIN_ENTRY(${PROJECT_NAME})

    target_sources(
        ${PROJECT_NAME}
        PRIVATE
        src/main.cpp
    )

    target_link_libraries(
        ${PROJECT_NAME}
        PRIVATE 
        HelloWorldCmd
    )

    # Uncomment this to enable installing to CMAKE_INSTALL_PREFIX.
    # install(TARGETS ${PROJECT_NAME} ${MAYA_TARGET_TYPE} DESTINATION .)

From Command Line
-----------------
    # CMake 3.x
    cmake -G "Visual Studio 14 2015 Win64" -DMAYA_VERSION=2018 ../
    cmake --build . --config Release

## note:
-----------------
https://stackoverflow.com/questions/1027247/is-it-better-to-specify-source-files-with-glob-or-each-file-individually-in-cmak/1060061
