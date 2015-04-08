#
# OpenColorIO_FOUND    
# OpenColorIO_INCLUDE_DIR
# OpenColorIO_LIBRARY


find_package(PackageHandleStandardArgs)

# try to find header
FIND_PATH(OpenColorIO_INCLUDE_DIR OpenColorIO/OpenColorIO.h
  $ENV{OPENCOLORIO_PATH}/include
  ${OpenColorIO_INSTALL_PATH}/include
  /usr/local/include
)

# try to find libs
FIND_LIBRARY(OpenColorIO_LIBRARY OpenColorIO
  $ENV{OPENCOLORIO_PATH}/lib
  $ENV{OPENCOLORIO_LIBRARY_PATH}
  ${OpenColorIO_INSTALL_PATH}/lib
  /usr/local/lib
)

# did we find everything?
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS("OpenColorIO" DEFAULT_MSG
  OpenColorIO_INCLUDE_DIR
  OpenColorIO_LIBRARY
)

mark_as_advanced(OpenColorIO_INCLUDE_DIR)
