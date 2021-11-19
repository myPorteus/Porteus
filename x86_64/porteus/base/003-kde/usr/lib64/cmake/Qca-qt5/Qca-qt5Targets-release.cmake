#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "qca-qt5" for configuration "Release"
set_property(TARGET qca-qt5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(qca-qt5 PROPERTIES
  IMPORTED_LOCATION_RELEASE "/usr/lib64/libqca-qt5.so.2.1.3"
  IMPORTED_SONAME_RELEASE "libqca-qt5.so.2"
  )

list(APPEND _IMPORT_CHECK_TARGETS qca-qt5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_qca-qt5 "/usr/lib64/libqca-qt5.so.2.1.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
