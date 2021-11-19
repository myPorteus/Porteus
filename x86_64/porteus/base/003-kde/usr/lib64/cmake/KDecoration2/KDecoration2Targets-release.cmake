#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KDecoration2::KDecoration2Private" for configuration "Release"
set_property(TARGET KDecoration2::KDecoration2Private APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KDecoration2::KDecoration2Private PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libkdecorations2private.so.5.15.5"
  IMPORTED_SONAME_RELEASE "libkdecorations2private.so.6"
  )

list(APPEND _IMPORT_CHECK_TARGETS KDecoration2::KDecoration2Private )
list(APPEND _IMPORT_CHECK_FILES_FOR_KDecoration2::KDecoration2Private "${_IMPORT_PREFIX}/lib64/libkdecorations2private.so.5.15.5" )

# Import target "KDecoration2::KDecoration" for configuration "Release"
set_property(TARGET KDecoration2::KDecoration APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KDecoration2::KDecoration PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KDecoration2::KDecoration2Private;KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libkdecorations2.so.5.15.5"
  IMPORTED_SONAME_RELEASE "libkdecorations2.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KDecoration2::KDecoration )
list(APPEND _IMPORT_CHECK_FILES_FOR_KDecoration2::KDecoration "${_IMPORT_PREFIX}/lib64/libkdecorations2.so.5.15.5" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
