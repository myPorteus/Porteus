
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5KDELibs4SupportConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib64/cmake/KF5KDELibs4Support" REALPATH)
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

# This needs to be set before finding dependencies, since it uses
# PACKAGE_PREFIX_DIR, which may be overwritten by the config files
# of other packages.
set(KDE4_DBUS_INTERFACES_DIR "${PACKAGE_PREFIX_DIR}/share/dbus-1/interfaces")

include(CMakeFindDependencyMacro)
find_dependency(KF5Auth "5.45.0")
find_dependency(KF5Archive "5.45.0")
find_dependency(KF5ConfigWidgets "5.45.0")
find_dependency(KF5CoreAddons "5.45.0")
find_dependency(KF5Crash "5.45.0")
find_dependency(KF5DesignerPlugin "5.45.0")
find_dependency(KF5DocTools "5.45.0")
find_dependency(KF5Emoticons "5.45.0")
find_dependency(KF5GuiAddons "5.45.0")
find_dependency(KF5IconThemes "5.45.0")
find_dependency(KF5ItemModels "5.45.0")
find_dependency(KF5Init "5.45.0")
find_dependency(KF5Notifications "5.45.0")
find_dependency(KF5Parts "5.45.0")
find_dependency(KF5TextWidgets "5.45.0")
find_dependency(KF5UnitConversion "5.45.0")
find_dependency(KF5WindowSystem "5.45.0")
find_dependency(KF5DBusAddons "5.45.0")

find_dependency(Qt5DBus 5.8.0)
find_dependency(Qt5Xml 5.8.0)
find_dependency(Qt5PrintSupport 5.8.0)

if(WIN32)
    find_dependency(KDEWin)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/KF5KDELibs4SupportTargets.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/ECMQt4To5Porting.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/KDE4Macros.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/MacroAppendIf.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/MacroEnsureOutOfSourceBuild.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/MacroBoolTo01.cmake")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")

remove_definitions(
  -DQT_NO_SIGNALS_SLOTS_KEYWORDS
  -DQT_NO_CAST_FROM_ASCII
  -DQT_NO_CAST_TO_ASCII
)

# This is not intended to be a list of what frameworks each of the kde libraries
# was broken into. KDE4_KDECORE_LIBS contains more than what used to be in
# the kdecore library. That is a feature. These things should be big ugly warts
# in any project using them. The KDELibs4Support module is not for long term use and
# it is not for 'making code build with both Qt/KDE 4 and Qt/KF 5' for medium or
# long term. In trivial cases, no use of KDELibs4Support will be pushed to the repo
# of the code being ported.
#
# The use-sequence is this:
# 1. When starting to port something to KF5, find and use KDELibs4Support.
# 2. Port the C++ code to Qt5/KF5.
# 3. Port the buildsystem away from KDELibs4Support.
# 4. Remove the find_package for KDELibs4Support.

set(KDE4_KDECORE_LIBS
  KF5::KDELibs4Support
  Qt5::Network
  Qt5::DBus
  Qt5::Xml
  KF5::KIOCore
  KF5::I18n
  KF5::CoreAddons
  KF5::Codecs
  KF5::ConfigCore
  KF5::WidgetsAddons
  KF5::ItemModels
  KF5::ConfigWidgets
  KF5::Completion
  KF5::XmlGui
  KF5::IconThemes
  KF5::KIOWidgets
  KF5::ItemViews
  KF5::Emoticons
)
set(KDE4_KDEUI_LIBS  ${KDE4_KDECORE_LIBS})
set(KDE4_KIO_LIBS ${KDE4_KDECORE_LIBS})
set(KDE4_KPARTS_LIBS ${KDE4_KPARTS_LIBS})
set(KDE4_KUTILS_LIBS ${KDE4_KUTILS_LIBS})
set(KDE4_KFILE_LIBS ${KDE4_KFILE_LIBS})
set(KDE4_KHTML_LIBS ${KDE4_KHTML_LIBS})
set(KDE4_KDELIBS4SUPPORT_LIBS  ${KDE4_KDECORE_LIBS})

set(KDE4_INCLUDES $<TARGET_PROPERTY:KF5::KDELibs4Support,INTERFACE_INCLUDE_DIRECTORIES>)
if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC" OR (WIN32 AND CMAKE_CXX_COMPILER_ID STREQUAL "Intel"))
  set (KDE4_ENABLE_EXCEPTIONS -EHsc)
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  set (KDE4_ENABLE_EXCEPTIONS "-fexceptions -UQT_NO_EXCEPTIONS")
elseif (CMAKE_CXX_COMPILER_ID STREQUAL "Intel")
  set (KDE4_ENABLE_EXCEPTIONS -fexceptions)
endif()
