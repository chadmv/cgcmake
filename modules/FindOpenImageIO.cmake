#
# OpenImageIO_FOUND    
# OpenImageIO_INCLUDE_DIR
# OpenImageIO_LIBRARY


find_package(PackageHandleStandardArgs)

# try to find header
FIND_PATH(OpenImageIO_INCLUDE_DIR OpenImageIO/imageio.h
  $ENV{IMAGEIO_PATH}/include
  ${OpenImageIO_INSTALL_PATH}/include
  /usr/local/include
)

# try to find libs
FIND_LIBRARY(OpenImageIO_LIBRARY OpenImageIO
  $ENV{IMAGEIO_PATH}/lib
  $ENV{IMAGEIO_LIBRARY_PATH}
  ${OpenImageIO_INSTALL_PATH}/lib
  /usr/local/lib
)

# did we find everything?
include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS("OpenImageIO" DEFAULT_MSG
  OpenImageIO_INCLUDE_DIR
  OpenImageIO_LIBRARY
)

set(OpenImageIO_LIBRARIES ${OpenImageIO_LIBRARY})

mark_as_advanced(OpenImageIO_INCLUDE_DIR OpenImageIO_LIBRARY)
