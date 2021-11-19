#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KIOCore" for configuration "Release"
set_property(TARGET KF5::KIOCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KIOCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Xml;KF5::I18n;KF5::Crash;KF5::DBusAddons;KF5::AuthCore"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KIOCore.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KIOCore.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOCore "${_IMPORT_PREFIX}/lib64/libKF5KIOCore.so.5.58.0" )

# Import target "KF5::KIONTLM" for configuration "Release"
set_property(TARGET KF5::KIONTLM APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KIONTLM PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KIONTLM.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KIONTLM.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIONTLM )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIONTLM "${_IMPORT_PREFIX}/lib64/libKF5KIONTLM.so.5.58.0" )

# Import target "KF5::KIOGui" for configuration "Release"
set_property(TARGET KF5::KIOGui APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KIOGui PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KIOGui.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KIOGui.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOGui )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOGui "${_IMPORT_PREFIX}/lib64/libKF5KIOGui.so.5.58.0" )

# Import target "KF5::KIOWidgets" for configuration "Release"
set_property(TARGET KF5::KIOWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KIOWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::Concurrent;Qt5::DBus;KF5::I18n;KF5::IconThemes;KF5::WindowSystem;KF5::ConfigWidgets"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KIOWidgets.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KIOWidgets.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOWidgets "${_IMPORT_PREFIX}/lib64/libKF5KIOWidgets.so.5.58.0" )

# Import target "KF5::KIOFileWidgets" for configuration "Release"
set_property(TARGET KF5::KIOFileWidgets APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KIOFileWidgets PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::IconThemes;KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KIOFileWidgets.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KIOFileWidgets.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KIOFileWidgets )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KIOFileWidgets "${_IMPORT_PREFIX}/lib64/libKF5KIOFileWidgets.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
