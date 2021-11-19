
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was PolkitQt-1Config.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib64/cmake/PolkitQt5-1" REALPATH)
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

# Config file for POLKITQT-1
# The following variables are defined:
# POLKITQT-1_FOUND       - True if POLKITQT-1 has been found.
# POLKITQT-1_INCLUDE_DIR - The include directory.
# POLKITQT-1_LIB_DIR     - The libraries directory.
# POLKITQT-1_LIBRARIES   - Libraries needed to use PolkitQt-1.

########## The PolkitQt-1 version ##########
set(POLKITQT-1_VERSION_MAJOR   0)
set(POLKITQT-1_VERSION_MINOR   112)
set(POLKITQT-1_VERSION_PATCH   0)
set(POLKITQT-1_VERSION         0.112.0)
set(POLKITQT-1_VERSION_STRING  "0.112.0")
#########################################

########## Install dirs ##########
if(NOT POLKITQT-1_INSTALL_DIR)
   set(POLKITQT-1_INSTALL_DIR "/usr")
endif(NOT POLKITQT-1_INSTALL_DIR)

set_and_check(POLKITQT-1_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include/polkit-qt5-1")
set_and_check(POLKITQT-1_INCLUDE_DIRS "${POLKITQT-1_INCLUDE_DIR}")
set_and_check(POLKITQT-1_LIB_DIR "${PACKAGE_PREFIX_DIR}/lib64")
set(POLKITQT-1_POLICY_FILES_INSTALL_DIR "${POLKITQT-1_INSTALL_DIR}/share/polkit-1/actions")
##################################

########## Compatibility ##########
if(WIN32)
if(MINGW)
  set(POLKITQT-1_CORE_LIBRARY         "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-core-1.dll.a")
  set(POLKITQT-1_AGENT_LIBRARY        "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-agent-1.dll.a")
  set(POLKITQT-1_GUI_LIBRARY          "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-gui-1.dll.a")
else(MINGW)
  set(POLKITQT-1_CORE_LIBRARY         "${POLKITQT-1_LIB_DIR}/polkit-qt5-core-1.lib")
  set(POLKITQT-1_AGENT_LIBRARY        "${POLKITQT-1_LIB_DIR}/polkit-qt5-agent-1.lib")
  set(POLKITQT-1_GUI_LIBRARY          "${POLKITQT-1_LIB_DIR}/polkit-qt5-gui-1.lib")
endif(MINGW)
elseif(APPLE)
  set(POLKITQT-1_CORE_LIBRARY         "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-core-1.dylib")
  set(POLKITQT-1_AGENT_LIBRARY        "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-agent-1.dylib")
  set(POLKITQT-1_GUI_LIBRARY          "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-gui-1.dylib")
else()
  set(POLKITQT-1_CORE_LIBRARY         "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-core-1.so")
  set(POLKITQT-1_AGENT_LIBRARY        "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-agent-1.so")
  set(POLKITQT-1_GUI_LIBRARY          "${POLKITQT-1_LIB_DIR}/libpolkit-qt5-gui-1.so")
endif()

########## The PolkitQt-1 libraries ##########
# Load the exported targets.
include("${CMAKE_CURRENT_LIST_DIR}/PolkitQt5-1Targets.cmake")
set(POLKITQT-1_LIBRARIES        PolkitQt5-1::Core PolkitQt5-1::Gui PolkitQt5-1::Agent)
###########################################

