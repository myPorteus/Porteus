#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::FileMetaData" for configuration "Release"
set_property(TARGET KF5::FileMetaData APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::FileMetaData PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n;KF5::CoreAddons"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5FileMetaData.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5FileMetaData.so.3"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::FileMetaData )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::FileMetaData "${_IMPORT_PREFIX}/lib64/libKF5FileMetaData.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
