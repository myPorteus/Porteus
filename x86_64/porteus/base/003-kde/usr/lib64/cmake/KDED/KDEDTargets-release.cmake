#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::kdeinit_kded5" for configuration "Release"
set_property(TARGET KF5::kdeinit_kded5 APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::kdeinit_kded5 PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libkdeinit5_kded5.so"
  IMPORTED_SONAME_RELEASE "libkdeinit5_kded5.so"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::kdeinit_kded5 )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::kdeinit_kded5 "${_IMPORT_PREFIX}/lib64/libkdeinit5_kded5.so" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
