#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::LsofUi" for configuration "Release"
set_property(TARGET KF5::LsofUi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::LsofUi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/liblsofui.so.5.12.3"
  IMPORTED_SONAME_RELEASE "liblsofui.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::LsofUi )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::LsofUi "${_IMPORT_PREFIX}/lib/liblsofui.so.5.12.3" )

# Import target "KF5::ProcessCore" for configuration "Release"
set_property(TARGET KF5::ProcessCore APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::ProcessCore PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libprocesscore.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libprocesscore.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ProcessCore )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ProcessCore "${_IMPORT_PREFIX}/lib/libprocesscore.so.5.12.3" )

# Import target "KF5::ProcessUi" for configuration "Release"
set_property(TARGET KF5::ProcessUi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::ProcessUi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::I18n;KF5::WindowSystem;KF5::Auth;KF5::Completion;KF5::ConfigWidgets;KF5::WidgetsAddons;KF5::IconThemes;Qt5::X11Extras;Qt5::WebKitWidgets"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libprocessui.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libprocessui.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::ProcessUi )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::ProcessUi "${_IMPORT_PREFIX}/lib/libprocessui.so.5.12.3" )

# Import target "KF5::SignalPlotter" for configuration "Release"
set_property(TARGET KF5::SignalPlotter APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::SignalPlotter PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::ProcessCore;KF5::Plasma"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libksignalplotter.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libksignalplotter.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::SignalPlotter )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::SignalPlotter "${_IMPORT_PREFIX}/lib/libksignalplotter.so.5.12.3" )

# Import target "KF5::SysGuard" for configuration "Release"
set_property(TARGET KF5::SysGuard APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::SysGuard PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n;KF5::CoreAddons;KF5::ConfigWidgets;KF5::ProcessCore"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libksgrd.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libksgrd.so.7"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::SysGuard )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::SysGuard "${_IMPORT_PREFIX}/lib/libksgrd.so.5.12.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
