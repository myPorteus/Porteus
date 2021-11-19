#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KioArchive" for configuration "Release"
set_property(TARGET KioArchive APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KioArchive PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::I18n"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libkioarchive.so.5.97.0"
  IMPORTED_SONAME_RELEASE "libkioarchive.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KioArchive )
list(APPEND _IMPORT_CHECK_FILES_FOR_KioArchive "${_IMPORT_PREFIX}/lib/libkioarchive.so.5.97.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
