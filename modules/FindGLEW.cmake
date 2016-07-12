# Try to find GLEW library and include path.
#
# Variables that will be defined:
# GLEW_FOUND
# GLEW_INCLUDE_DIR
# GLEW_LIBRARY
#

find_path(GLEW_INCLUDE_DIR
    NAMES
        GL/glew.h
    PATHS
        ${GLEW_LOCATION}/include
        $ENV{GLEW_LOCATION}/include
        $ENV{PROGRAMFILES}/glew/include
        /usr/include
        /usr/local/include
        /sw/include
        /opt/local/include
        NO_DEFAULT_PATH
    DOC
        "The directory where GL/glew.h resides"
)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(LIB_DIR "x64" )
else()
    set(LIB_DIR "Win32" )
endif()

find_library(GLEW_LIBRARY
    NAMES
        glew32s
    PATHS
        ${GLEW_LOCATION}/lib
        $ENV{GLEW_LOCATION}/lib
        $ENV{PROGRAMFILES}/glew/lib
        /usr/lib64
        /usr/lib
        /usr/local/lib64
        /usr/local/lib
        /sw/lib
        /opt/local/lib
    PATH_SUFFIXES
        "Release/${LIB_DIR}"
        "Release MX/${LIB_DIR}"
    DOC "The GLEW library"
)


set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDE_DIR})
set(GLEW_LIBRARIES ${GLEW_LIBRARY})


include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLEW REQUIRED_VARS GLEW_INCLUDE_DIR GLEW_LIBRARY)

if(GLEW_FOUND AND NOT TARGET GLEW::GLEW)
  add_library(GLEW::GLEW UNKNOWN IMPORTED)
  set_target_properties(GLEW::GLEW PROPERTIES
    IMPORTED_LOCATION "${GLEW_LIBRARY}"
    INTERFACE_INCLUDE_DIRECTORIES "${GLEW_INCLUDE_DIRS}")
endif()

mark_as_advanced(GLEW_FOUND GLEW_INCLUDE_DIR GLEW_LIBRARY)

