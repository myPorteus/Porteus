#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "KF5::JS" for configuration "Release"
set_property(TARGET KF5::JS APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::JS PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5JS.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5JS.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::JS )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::JS "${_IMPORT_PREFIX}/lib64/libKF5JS.so.5.45.0" )

# Import target "KF5::JSApi" for configuration "Release"
set_property(TARGET KF5::JSApi APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(KF5::JSApi PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::JS"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libKF5JSApi.so.5.45.0"
  IMPORTED_SONAME_RELEASE "libKF5JSApi.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS KF5::JSApi )
list(APPEND _IMPORT_CHECK_FILES_FOR_KF5::JSApi "${_IMPORT_PREFIX}/lib64/libKF5JSApi.so.5.45.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
