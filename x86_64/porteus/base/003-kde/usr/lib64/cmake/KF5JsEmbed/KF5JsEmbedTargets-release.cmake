#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::JsEmbed" for configuration "Release"
set_property(TARGET KF5::JsEmbed APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::JsEmbed PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Widgets;Qt5::Xml;Qt5::Svg"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5JsEmbed.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5JsEmbed.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::JsEmbed )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::JsEmbed "${_IMPORT_PREFIX}/lib64/libKF5JsEmbed.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
