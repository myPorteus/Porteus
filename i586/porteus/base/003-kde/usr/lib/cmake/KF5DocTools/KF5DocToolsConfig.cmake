
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5DocToolsConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib/cmake/KF5DocTools" REALPATH)
if(_realCurr STREQUAL _realOrig)
  set(PACKAGE_PREFIX_DIR "/usr")
endif()
unset(_realOrig)
unset(_realCurr)

macro(set_and_check _var _file)
  set(${_var} "${_file}")
  if(NOT EXISTS "${_file}")
    message(FATAL_ERROR "File or directory ${_file} referenced by variable ${_var} does not exist !")
  endif()
endmacro()

macro(check_required_components _NAME)
  foreach(comp ${${_NAME}_FIND_COMPONENTS})
    if(NOT ${_NAME}_${comp}_FOUND)
      if(${_NAME}_FIND_REQUIRED_${comp})
        set(${_NAME}_FOUND FALSE)
      endif()
    endif()
  endforeach()
endmacro()

####################################################################################

set(KDOCTOOLS_DATA_INSTALL_DIR "${PACKAGE_PREFIX_DIR}/share/kf5")
set(KDOCTOOLS_CUSTOMIZATION_DIR "${KDOCTOOLS_DATA_INSTALL_DIR}/kdoctools/customization")

include("${CMAKE_CURRENT_LIST_DIR}/KF5DocToolsTargets.cmake")

if(CMAKE_CROSSCOMPILING AND MEINPROC5_EXECUTABLE)
    set_target_properties(KF5::meinproc5 PROPERTIES IMPORTED_LOCATION_NONE ${MEINPROC5_EXECUTABLE})
    set_target_properties(KF5::meinproc5 PROPERTIES IMPORTED_LOCATION ${MEINPROC5_EXECUTABLE})
endif()

if(CMAKE_CROSSCOMPILING AND DOCBOOKL10NHELPER_EXECUTABLE)
    set_target_properties(KF5::docbookl10nhelper PROPERTIES IMPORTED_LOCATION_NONE ${DOCBOOKL10NHELPER_EXECUTABLE})
    set_target_properties(KF5::docbookl10nhelper PROPERTIES IMPORTED_LOCATION ${DOCBOOKL10NHELPER_EXECUTABLE})
endif()

if(CMAKE_CROSSCOMPILING AND CHECKXML5_EXECUTABLE)
    set_target_properties(KF5::checkXML5 PROPERTIES IMPORTED_LOCATION_NONE ${CHECKXML5_EXECUTABLE})
    set_target_properties(KF5::checkXML5 PROPERTIES IMPORTED_LOCATION ${CHECKXML5_EXECUTABLE})
endif()

include(${CMAKE_CURRENT_LIST_DIR}/KF5DocToolsMacros.cmake)

# find_dependency must be called *after* including the macros or PACKAGE_PREFIX_DIR will be altered
include(CMakeFindDependencyMacro)
find_dependency(Qt5Core 5.8.0)
