#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "PW::LibColorCorrect" for configuration "Release"
set_property(TARGET PW::LibColorCorrect APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(PW::LibColorCorrect PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::WindowSystem;KF5::I18n;Qt5::DBus"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libcolorcorrect.so.5.12.3"
  IMPORTED_SONAME_RELEASE "libcolorcorrect.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS PW::LibColorCorrect )
list(APPEND _IMPORT_CHECK_FILES_FOR_PW::LibColorCorrect "${_IMPORT_PREFIX}/lib64/libcolorcorrect.so.5.12.3" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
