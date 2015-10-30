# - Finds the installation directory of Visual Studio.
# This is mostly useful to be able to add the UnitTest include and lib directories to a project
# because by default, VS uses an internal VCInstallDir variable.
#
# Variables that will be defined:
# VisualStudio_FOUND  Defined if a Visual Studio installation has been detected
# VC_INSTALL_DIR      Path to Visual Studio VC directory
# VC_UNITTEST_INCLUDE_DIR Path to the VC UnitTest include directory
# VC_UNITTEST_LIB_DIR Path to the VC UnitTest lib directory
#
# Example CMakeLists.txt:
# cmake_minimum_required(VERSION 2.8)
# project(tests)
# find_package(VisualStudio REQUIRED)
# include_directories("${VC_UNITTEST_INCLUDE_DIR}")
# link_directories("${VC_UNITTEST_LIB_DIR}")
# add_library(tests SHARED test.cpp)
#

if(MSVC)
    set(VC_INSTALL_DIR "C:/Program Files (x86)/Microsoft Visual Studio ")
    
    if(${MSVC_VERSION} EQUAL 1900)
        set(VS_VERSION "14.0")
    elseif(${MSVC_VERSION} EQUAL 1800)
        set(VS_VERSION "12.0")
    elseif(${MSVC_VERSION} EQUAL 1700)
        set(VS_VERSION "11.0")
    elseif(${MSVC_VERSION} EQUAL 1600)
        set(VS_VERSION "10.0")
    endif()
    
    set(VC_INSTALL_DIR "${VC_INSTALL_DIR}${VS_VERSION}/VC")
    
    # VC install directory
    find_path(VC_INSTALL_DIR include/iostream
        PATHS
            ${VC_INSTALL_DIR}
        DOC "VC install path"
    )

    # VC UnitTest include directory
    find_path(VC_UNITTEST_INCLUDE_DIR CppUnitTest.h
        PATHS
            ${VC_INSTALL_DIR}
        PATH_SUFFIXES
            "UnitTest/include"
        DOC "VC UnitTest include directory"
    )

    # VC UnitTest lib directory
    find_path(VC_UNITTEST_LIB_DIR Microsoft.VisualStudio.TestTools.CppUnitTestFramework.lib
        PATHS
            ${VC_INSTALL_DIR}
        PATH_SUFFIXES
            "UnitTest/lib"
        DOC "VC UnitTest lib directory"
    )
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(VisualStudio DEFAULT_MSG
                                  VC_INSTALL_DIR
                                  VC_UNITTEST_INCLUDE_DIR
                                  VC_UNITTEST_LIB_DIR)
