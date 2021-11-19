#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KDE4__KDELibs4Support" for configuration "Release"
set_property(TARGET KDE4__KDELibs4Support APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KDE4__KDELibs4Support PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::GlobalAccel;Qt5::Svg;Qt5::Test;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KDELibs4Support.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KDELibs4Support.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KDE4__KDELibs4Support )
list(APPEND _IMPORT_CHECK_FILES_FOR_KDE4__KDELibs4Support "${_IMPORT_PREFIX}/lib64/libKF5KDELibs4Support.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
