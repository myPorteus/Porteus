#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PW::KScreenLocker" for configuration "Release"
set_property(TARGET PW::KScreenLocker APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(PW::KScreenLocker PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::I18n;KF5::IdleTime;KF5::GlobalAccel;KF5::Notifications;KF5::CoreAddons;KF5::ConfigGui;KF5::WindowSystem;KF5::WaylandServer"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKScreenLocker.so.5.15.5"
  IMPORTED_SONAME_RELEASE "libKScreenLocker.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS PW::KScreenLocker )
list(APPEND _IMPORT_CHECK_FILES_FOR_PW::KScreenLocker "${_IMPORT_PREFIX}/lib64/libKScreenLocker.so.5.15.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
