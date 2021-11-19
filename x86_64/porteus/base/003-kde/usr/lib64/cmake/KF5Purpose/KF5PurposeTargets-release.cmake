#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::Purpose" for configuration "Release"
set_property(TARGET KF5::Purpose APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::Purpose PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::Network;KF5::ConfigCore"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5Purpose.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5Purpose.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::Purpose )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::Purpose "${_IMPORT_PREFIX}/lib64/libKF5Purpose.so.5.58.0" )

# Import target "KF5::PurposeWidgets" for configuration "Release"
set_property(TARGET KF5::PurposeWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::PurposeWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Qml;KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5PurposeWidgets.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5PurposeWidgets.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::PurposeWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::PurposeWidgets "${_IMPORT_PREFIX}/lib64/libKF5PurposeWidgets.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
