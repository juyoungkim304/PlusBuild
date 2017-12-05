###############################################################################
# Find Intel RealSense SDK 2.0
#
#     find_package(RealSense)
#
# Variables defined by this module:
#
#  RSSDK_FOUND                 True if RealSense SDK 2.0 was found
#  RSSDK_VERSION               The version of RealSense SDK 2.0
#  RSSDK_INCLUDE_DIR           The location(s) of RealSense SDK 2.0 headers
#  RSSDK_LIBRARY               Libraries needed to use RealSense SDK 2.0
#  RSSDK_BINARY			       DLL's needed to use RealSense SDK 2.0

find_path(RSSDK_DIR "include/librealsense2/rs.hpp"
          PATHS "$ENV{RSSDK_DIR}"
                "$ENV{PROGRAMFILES}/Intel RealSense SDK 2.0"
                "$ENV{PROGRAMW6432}/Intel RealSense SDK 2.0"
                "C:/Program Files (x86)/Intel RealSense SDK 2.0"
                "C:/Program Files/Intel RealSense SDK 2.0"
          DOC "RealSense SDK directory")

if(RSSDK_DIR)

  # Include directories
  set(RSSDK_INCLUDE_DIR ${RSSDK_DIR}/include)
  mark_as_advanced(RSSDK_INCLUDE_DIR)

  # Libraries
  set(RSSDK_LIBRARY_NAME realsense2.lib)

  SET(PLATFORM "x86")
  IF (CMAKE_HOST_WIN32 AND CMAKE_CL_64 )
    SET(PLATFORM "x64")
  ENDIF (CMAKE_HOST_WIN32 AND CMAKE_CL_64 )

  find_library(RSSDK_LIBRARY
               NAMES ${RSSDK_LIBRARY_NAME}
               PATHS "${RSSDK_DIR}/lib/${PLATFORM}/" NO_DEFAULT_PATH)
		
  # Binaries
  set(RSSDK_BINARY_NAME realsense2.dll)
  find_path(RSSDK_BINARY
            NAMES ${RSSDK_BINARY_NAME}
            PATHS "${RSSDK_DIR}/bin/${PLATFORM}/" NO_DEFAULT_PATH)
 
  set(RSSDK_BINARY "${RSSDK_BINARY}/${RSSDK_BINARY_NAME}")
  mark_as_advanced(RSSDK_LIBRARY RSSDK_BINARY RSSDK_LIBRARY_NAME RSSDK_BINARY_NAME)

  # Version
  set(RSSDK_VERSION 0)
  # file(STRINGS "${RSSDK_INCLUDE_DIRS}/pxcversion.h" _pxcversion_H_CONTENTS REGEX "#define PXC_VERSION_.*")
  # set(_RSSDK_VERSION_REGEX "([0-9]+)")
  # foreach(v MAJOR MINOR BUILD REVISION)
    # if("${_pxcversion_H_CONTENTS}" MATCHES ".*#define PXC_VERSION_${v} *${_RSSDK_VERSION_REGEX}.*")
      # set(RSSDK_VERSION_${v} "${CMAKE_MATCH_1}")
    # endif()
  # endforeach()
  # unset(_pxcversion_H_CONTENTS)
  # set(RSSDK_VERSION "${RSSDK_VERSION_MAJOR}.${RSSDK_VERSION_MINOR}.${RSSDK_VERSION_BUILD}.${RSSDK_VERSION_REVISION}")

endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(RSSDK
  FOUND_VAR RSSDK_FOUND
  REQUIRED_VARS RSSDK_INCLUDE_DIR RSSDK_LIBRARY RSSDK_BINARY
  VERSION_VAR RSSDK_VERSION
)