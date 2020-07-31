# cgcmake
CMake modules for common applications related to computer graphics

# Sample Usage

## Maya Project

```
|-- CMakeLists.txt
|-- cgcmake
    |-- modules
        |-- FindMaya.cmake
|-- src
    |-- CMakeLists.txt
    |-- pluginMain.cpp
    |-- sampleCmd.cpp
    |-- sampleCmd.h
```

### Root CMakeLists.txt

```
cmake_minimum_required(VERSION 3.1...3.15)

if(${CMAKE_VERSION} VERSION_LESS 3.12)
    cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

cmake_policy(SET CMP0048 NEW)

project(MayaProjectName VERSION 1.0 DESCRIPTION "My Maya Plug-in" LANGUAGES CXX)

set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cgcmake/modules)

add_subdirectory(src)
```

### src/CMakeLists.txt

```
set(SOURCE_FILES
    "pluginMain.cpp"
    "sampleCmd.h"
    "sampleCmd.cpp"
)

find_package(Maya REQUIRED)

add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})

target_link_libraries(${PROJECT_NAME} PRIVATE Maya::Maya)
target_include_directories(${PROJECT_NAME} 
    PRIVATE Maya::Maya
    PUBLIC "${CMAKE_CURRENT_BINARY_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}"
)
MAYA_PLUGIN(${PROJECT_NAME})

install(TARGETS ${PROJECT_NAME} ${MAYA_TARGET_TYPE} DESTINATION plug-ins/${MAYA_VERSION})
```

#### Windows

In a Command Prompt from the root of the project

Pre-Maya 2020
```
mkdir build.2019
cd build.2019
cmake -A x64 -T v140 -DMAYA_VERSION=2019 ../
cmake --build . --target install --config Release
```

Maya 2020
```
mkdir build.2020
cd build.2020
cmake -A x64 -T v141 -DMAYA_VERSION=2020 ../
cmake --build . --target install --config Release
```
