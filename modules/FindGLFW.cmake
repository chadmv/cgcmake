#.rst:
# FindGLFW
# --------
#
# Find GLFW
#
# Find the GLFW includs and library.  This module defines
#
# ::
#
#   GLFW_INCLUDE_DIR, where to find glfw.h, etc.
#   GLFW_LIBRARIES, the libraries needed to use GLFW.
#   GLFW_FOUND, If false, do not try to use GLFW.
#
# ::
#

find_path(GLFW_INCLUDE_DIR
    NAMES
        GLFW/glfw3.h
    PATHS
        ${GLFW_LOCATION}/include
        $ENV{GLFW_LOCATION}/include
        $ENV{PROGRAMFILES}/glfw/include
        /usr/include
        /usr/local/include
        /sw/include
        /opt/local/include
        NO_DEFAULT_PATH
    DOC
        "The directory where GLFW/glfw.h resides"
)

find_library(GLFW_LIBRARY
    NAMES
        glfw3 
    PATHS
        ${GLFW_LOCATION}/lib64
        ${GLFW_LOCATION}/lib
        $ENV{GLFW_LOCATION}/lib64
        $ENV{GLFW_LOCATION}/lib
        $ENV{PROGRAMFILES}/glfw/lib
        /usr/lib64
        /usr/lib
        /usr/local/lib64
        /usr/local/lib
        /sw/lib
        /opt/local/lib
        NO_DEFAULT_PATH
    DOC "The GLFW library"
)


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLFW REQUIRED_VARS GLFW_INCLUDE_DIR GLFW_LIBRARY)

if(GLFW_FOUND)
    set(GLFW_LIBRARIES ${GLFW_LIBRARY})
endif()

mark_as_advanced(GLFW_FOUND GLFW_INCLUDE_DIR GLFW_LIBRARY)
