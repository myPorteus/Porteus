#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KrossCore" for configuration "Release"
set_property(TARGET KF5::KrossCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KrossCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Widgets;KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KrossCore.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5KrossCore.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KrossCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KrossCore "${_IMPORT_PREFIX}/lib64/libKF5KrossCore.so.5.45.0" )

# Import target "KF5::KrossUi" for configuration "Release"
set_property(TARGET KF5::KrossUi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KrossUi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n;KF5::IconThemes"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KrossUi.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5KrossUi.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KrossUi )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KrossUi "${_IMPORT_PREFIX}/lib64/libKF5KrossUi.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
