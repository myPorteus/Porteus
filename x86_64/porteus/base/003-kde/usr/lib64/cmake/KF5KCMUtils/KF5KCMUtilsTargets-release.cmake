#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::KCMUtils" for configuration "Release"
set_property(TARGET KF5::KCMUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::KCMUtils PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;Qt5::Qml;Qt5::Quick;Qt5::QuickWidgets;KF5::CoreAddons;KF5::I18n;KF5::IconThemes;KF5::ItemViews;KF5::XmlGui;KF5::QuickAddons;KF5::Declarative;KF5::Package"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5KCMUtils.so.5.58.0"
  IMPORTED_SONAME_RELEASE "libKF5KCMUtils.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::KCMUtils )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::KCMUtils "${_IMPORT_PREFIX}/lib64/libKF5KCMUtils.so.5.58.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
