# PTex finder module
#
# Variables that will be defined:
# PTEX_FOUND
# PTEX_INCLUDE_DIR
# PTEX_LIBRARY

find_path(PTEX_INCLUDE_DIR
  NAMES
    Ptexture.h
  PATHS
    "${PTEX_LOCATION}/include"
    "$ENV{PTEX_LOCATION}/include"
    "$ENV{PROGRAMFILES}/Ptex/include"
    "/usr/include"
    "/usr/local/include"
  DOC "The Ptex include directory"
)

find_library(PTEX_LIBRARY
  NAMES
    Ptex32 Ptex32s libPtex.a Ptex 
  PATHS
    "${PTEX_LOCATION}/lib"
    "$ENV{PTEX_LOCATION}/lib"
    "$ENV{PROGRAMFILES}/Ptex/lib"
    /usr/lib
    /usr/local/lib
    DOC "The Ptex library"
)

if (PTEX_INCLUDE_DIR)
    file(STRINGS "${PTEX_INCLUDE_DIR}/Ptexture.h" TMP REGEX "^#define PtexAPIVersion.*$")
    string(REGEX MATCHALL "[0-9]+" API ${TMP})
    
    file(STRINGS "${PTEX_INCLUDE_DIR}/Ptexture.h" TMP REGEX "^#define PtexFileMajorVersion.*$")
    string(REGEX MATCHALL "[0-9]+" MAJOR ${TMP})

    file(STRINGS "${PTEX_INCLUDE_DIR}/Ptexture.h" TMP REGEX "^#define PtexFileMinorVersion.*$")
    string(REGEX MATCHALL "[0-9]+" MINOR ${TMP})

    set(PTEX_VERSION ${API}.${MAJOR}.${MINOR})
endif()

include(FindPackageHandleStandardArgs)

find_package_handle_standard_args(PTex 
    REQUIRED_VARS
        PTEX_INCLUDE_DIR
        PTEX_LIBRARY
    VERSION_VAR
        PTEX_VERSION
)

if (PTEX_FOUND)
    set(PTEX_LIBRARIES ${PTEX_LIBRARY})
endif()

mark_as_advanced(
  PTEX_INCLUDE_DIR
  PTEX_LIBRARY
)

