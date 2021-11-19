#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "Okular::Core" for configuration "Release"
set_property(TARGET Okular::Core APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(Okular::Core PROPERTIES
  IMPORTED_LINK_DEPENDENT_LIBRARIES_RELEASE "KF5::Archive;KF5::KIOCore;KF5::KIOWidgets;KF5::I18n;KF5::ThreadWeaver;KF5::Bookmarks;Phonon::phonon4qt5;KF5::Wallet;KF5::JS;KF5::JSApi"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib64/libOkular5Core.so.9.0.0"
  IMPORTED_SONAME_RELEASE "libOkular5Core.so.9"
  )

list(APPEND _IMPORT_CHECK_TARGETS Okular::Core )
list(APPEND _IMPORT_CHECK_FILES_FOR_Okular::Core "${_IMPORT_PREFIX}/lib64/libOkular5Core.so.9.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
