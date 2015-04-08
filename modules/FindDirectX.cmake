# - Try to find DirectX
# Once done this will define
#
# DirectX_FOUND
# DirectX_ROOT_DIR
# DirectX_BIN_DIR
# DirectX_LIBRARY_DIR
# DirectX_INCLUDE_DIR
# DirectX_LIBRARIES
# DirectX_d3d11_LIBRARY
# DirectX_d3dcompiler_LIBRARY
# DirectX_dxguid_LIBRARY
# DirectX_dxgi_LIBRARY

if (WIN32)
    if(CMAKE_CL_64)
        set (DirectX_ARCHITECTURE x64)
    else()
        set (DirectX_ARCHITECTURE x86)
    endif()

    # With VS 2012 and Windows 8 SDK, the DirectX SDK is included as part of
    # the Windows SDK.
    find_path(DirectX_ROOT_DIR
        "Include/um/d3d11.h"
        PATHS
            "C:/Program Files/Windows Kits/8.1"
            "C:/Program Files (x86)/Windows Kits/8.1"
            "C:/Program Files/Windows Kits/8.0"
            "C:/Program Files (x86)/Windows Kits/8.0"
        DOC "DirectX root directory"
    )
    set(DirectX_BIN_SEARCH_PATH "${DirectX_ROOT_DIR}/bin")
    # If the Windows 8 SDK wasn't found, look for the DirectX SDK instead
    if("${DirectX_ROOT_DIR}" STREQUAL "DirectX_ROOT_DIR-NOTFOUND")
        find_path (DirectX_ROOT_DIR
            Include/d3d9.h
            PATHS
                "$ENV{DXSDK_DIR}"
                "C:/Program Files/Microsoft DirectX SDK (June 2010)"
                "C:/Program Files (x86)/Microsoft DirectX SDK (June 2010)"
            DOC "DirectX SDK root directory"
        )
        set(DirectX_BIN_SEARCH_PATH "${DirectX_ROOT_DIR}/Utilities/bin")
    endif()

    # DirectX library directory
    find_path(DirectX_LIBRARY_DIR d3d11.lib
        PATHS
          "${DirectX_LIB_SEARCH_PATH}"
          "${DirectX_ROOT_DIR}/Lib/Win8/um"
          "${DirectX_ROOT_DIR}/Lib/winv6.3/um/"
        PATH_SUFFIXES
          "${DirectX_ARCHITECTURE}/"
        DOC "DirectX library path"
    )

    set(DirectX_INCLUDE_SEARCH_PATHS
        "${DirectX_ROOT_DIR}/Include/um"
        "${DirectX_ROOT_DIR}/Include/shared"
        "${DirectX_ROOT_DIR}/Include"
    )

    # DirectX include directory
    find_path(DirectX_INCLUDE_DIR d3d11.h
      PATHS
        ${DirectX_INCLUDE_SEARCH_PATHS}
      DOC "DirectX include path"
    )

    # On Windows 8 sdk there are two include dirs
    find_path(DirectX_INCLUDE_DIR2 windef.h
      PATHS
        ${DirectX_INCLUDE_SEARCH_PATHS}
      DOC "DirectX include path"
    )
    set(DirectX_INCLUDE_DIR "${DirectX_INCLUDE_DIR}" "${DirectX_INCLUDE_DIR2}")

    # DirectX bin directory
    find_path(DirectX_BIN_DIR fxc.exe
      PATHS
          ${DirectX_BIN_SEARCH_PATH}
      PATH_SUFFIXES
          "${DirectX_ARCHITECTURE}/"
      DOC "DirectX bin path"
    )

    # DirectX libraries
    set(_DirectX_LIBRARIES d3d11 d3dcompiler dxguid dxgi)
    foreach(DirectX_LIB ${_DirectX_LIBRARIES})
        find_library(DirectX_${DirectX_LIB}_LIBRARY NAMES ${DirectX_LIB} PATHS ${DirectX_LIBRARY_DIR}
            NO_DEFAULT_PATH)
        set(DirectX_LIBRARIES ${DirectX_LIBRARIES} ${DirectX_${DirectX_LIB}_LIBRARY})
        mark_as_advanced(${DirectX_${DirectX_LIB}_LIBRARY})
    endforeach()
    mark_as_advanced(${DirectX_LIBRARIES})
endif()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(DirectX DEFAULT_MSG DirectX_ROOT_DIR DirectX_LIBRARIES
                                  DirectX_INCLUDE_DIR DirectX_LIBRARY_DIR DirectX_BIN_DIR)
