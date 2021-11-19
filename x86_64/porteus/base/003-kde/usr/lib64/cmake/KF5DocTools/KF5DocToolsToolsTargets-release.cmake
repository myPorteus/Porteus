#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::meinproc5" for configuration "Release"
set_property(TARGET KF5::meinproc5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::meinproc5 PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/meinproc5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::meinproc5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::meinproc5 "${_IMPORT_PREFIX}/bin/meinproc5" )

# Import target "KF5::checkXML5" for configuration "Release"
set_property(TARGET KF5::checkXML5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::checkXML5 PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/bin/checkXML5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::checkXML5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::checkXML5 "${_IMPORT_PREFIX}/bin/checkXML5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
