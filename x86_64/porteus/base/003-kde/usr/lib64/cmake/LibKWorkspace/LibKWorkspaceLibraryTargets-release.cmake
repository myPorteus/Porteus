#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PW::KWorkspace" for configuration "Release"
set_property(TARGET PW::KWorkspace APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(PW::KWorkspace PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "Qt5::DBus;KF5::I18n;KF5::WindowSystem;KF5::Plasma;Qt5::X11Extras"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libkworkspace5.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libkworkspace5.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS PW::KWorkspace )
list(APPEND _IMPORT_CHECK_FILES_FOR_PW::KWorkspace "${_IMPORT_PREFIX}/lib64/libkworkspace5.so.5.12.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
