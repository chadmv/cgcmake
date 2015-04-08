# - Try to find KINECT
# Once done this will define
#
# KINECT_FOUND
# KINECT_ROOT_DIR
# KINECT_BIN_DIR
# KINECT_LIBRARY_DIR
# KINECT_INCLUDE_DIR
# KINECT_LIBRARIES
# KINECT_Kinect10_LIBRARY

if (WIN32)
    set(KINECT_VERSION v1.8)
    if(CMAKE_CL_64)
        set (KINECT_ARCHITECTURE amd64)
    else()
        set (KINECT_ARCHITECTURE x86)
    endif()

    find_path(KINECT_ROOT_DIR
        "inc/NuiApi.h"
        PATHS
        "$ENV{ProgramW6432}/Microsoft SDKs/Kinect/${KINECT_VERSION}"
        DOC "Kinect root directory"
    )
    set(KINECT_INC_SEARCH_PATH "${KINECT_ROOT_DIR}/inc")
    set(KINECT_LIB_SEARCH_PATH "${KINECT_ROOT_DIR}/lib")
    set(KINECT_BIN_SEARCH_PATH "${KINECT_ROOT_DIR}/Assemblies")

    # KINECT library directory
    find_path(KINECT_LIBRARY_DIR Kinect10.lib
        PATHS
          ${KINECT_LIB_SEARCH_PATH}
        PATH_SUFFIXES
          "${KINECT_ARCHITECTURE}/"
        DOC "KINECT library path"
    )

    # KINECT include directory
    find_path(KINECT_INCLUDE_DIR NuiApi.h
      PATHS
          ${KINECT_INC_SEARCH_PATH}
      DOC "KINECT include path"
    )

    # KINECT bin directory
    find_path(KINECT_BIN_DIR Microsoft.Kinect.dll
      PATHS
          ${KINECT_BIN_SEARCH_PATH}
      DOC "KINECT bin path"
    )

    # KINECT libraries
    set(_KINECT_LIBRARIES Kinect10)
    foreach(KINECT_LIB ${_KINECT_LIBRARIES})
        find_library(KINECT_${KINECT_LIB}_LIBRARY NAMES ${KINECT_LIB} PATHS ${KINECT_LIBRARY_DIR}
            NO_DEFAULT_PATH)
        set(KINECT_LIBRARIES ${KINECT_LIBRARIES} ${KINECT_${KINECT_LIB}_LIBRARY})
        mark_as_advanced(${KINECT_${KINECT_LIB}_LIBRARY})
    endforeach()
    mark_as_advanced(${KINECT_LIBRARIES})
endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(KINECT DEFAULT_MSG KINECT_ROOT_DIR KINECT_LIBRARIES
                                  KINECT_INCLUDE_DIR KINECT_LIBRARY_DIR KINECT_BIN_DIR)
