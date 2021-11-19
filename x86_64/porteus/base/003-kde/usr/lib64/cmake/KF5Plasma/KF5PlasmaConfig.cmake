
####### Expanded from @PACKAGE_INIT@ by configure_package_config_file() #######
####### Any changes to this file will be overwritten by the next CMake run ####
####### The input file was KF5PlasmaConfig.cmake.in                            ########

get_filename_component(PACKAGE_PREFIX_DIR "${CMAKE_CURRENT_LIST_DIR}/../../../" ABSOLUTE)

# Use original install prefix when loaded through a "/usr move"
# cross-prefix symbolic link such as /lib -> /usr/lib.
get_filename_component(_realCurr "${CMAKE_CURRENT_LIST_DIR}" REALPATH)
get_filename_component(_realOrig "/usr/lib64/cmake/KF5Plasma" REALPATH)
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

# Any changes in this ".cmake" file will be overwritten by CMake, the source is the ".cmake.in" file.

include("${CMAKE_CURRENT_LIST_DIR}/KF5PlasmaTargets.cmake")


set(Plasma_INSTALL_PREFIX "${PACKAGE_PREFIX_DIR}")

set(Plasma_LIBRARIES KF5::Plasma)

set(PLASMA_DATAENGINES_PLUGINDIR ${KDE_INSTALL_PLUGINDIR}/plasma/dataengine)
set(PLASMA_PLASMOIDS_PLUGINDIR ${KDE_INSTALL_PLUGINDIR}/plasma/applets)
set(PLASMA_SCRIPTENGINES_PLUGINDIR ${KDE_INSTALL_PLUGINDIR}/plasma/scriptengines)
set(PLASMA_CONTAINMENTACTIONS_PLUGINDIR ${KDE_INSTALL_PLUGINDIR}/plasma/containmentactions)

include(CMakeFindDependencyMacro)
find_dependency(Qt5Gui "5.8.0")
find_dependency(KF5Package "5.45.0")
find_dependency(KF5Service "5.45.0")
find_dependency(KF5WindowSystem "5.45.0")

####################################################################################
# CMAKE_AUTOMOC

if(NOT CMAKE_VERSION VERSION_LESS "3.10.0")
    # CMake 3.9+ warns about automoc on files without Q_OBJECT, and doesn't know about other macros.
    # 3.10+ lets us provide more macro names that require automoc.
    list(APPEND CMAKE_AUTOMOC_MACRO_NAMES K_EXPORT_PLASMA_SERVICE;K_EXPORT_PLASMA_APPLET;K_EXPORT_PLASMA_PACKAGE;K_EXPORT_PLASMA_APPLETSCRIPTENGINE;K_EXPORT_PLASMA_DATAENGINESCRIPTENGINE;K_EXPORT_PLASMA_DATAENGINE;K_EXPORT_PLASMA_PACKAGE_WITH_JSON;K_EXPORT_PLASMA_SERVICE_WITH_JSON;K_EXPORT_PLASMA_APPLET_WITH_JSON;K_EXPORT_PLASMA_APPLETSCRIPTENGINE_WITH_JSON;K_EXPORT_PLASMA_DATAENGINESCRIPTENGINE_WITH_JSON;K_EXPORT_PLASMA_CONTAINMENTACTIONS_WITH_JSON;K_EXPORT_PLASMA_DATAENGINE_WITH_JSON)
endif()

if(NOT CMAKE_VERSION VERSION_LESS "3.9.0")
    # CMake's automoc needs help to find names of plugin metadata files in case Q_PLUGIN_METADATA
    # is indirectly used via other C++ preprocessor macros
    # 3.9+ lets us provide some filter rule pairs (keyword, regexp) to match the names of such files
    # in the plain text of the sources. See AUTOMOC_DEPEND_FILTERS docs for details.
    foreach(macro_name  K_EXPORT_PLASMA_PACKAGE_WITH_JSON)
        list(APPEND CMAKE_AUTOMOC_DEPEND_FILTERS
            "${macro_name}"
            "[\n^][ \t]*${macro_name}[ \t\n]*\\([^,]*,[ \t\n]*\"([^\"]+)\""
        )
    endforeach()
    foreach(macro_name  K_EXPORT_PLASMA_SERVICE_WITH_JSON;K_EXPORT_PLASMA_APPLET_WITH_JSON;K_EXPORT_PLASMA_APPLETSCRIPTENGINE_WITH_JSON;K_EXPORT_PLASMA_DATAENGINESCRIPTENGINE_WITH_JSON;K_EXPORT_PLASMA_CONTAINMENTACTIONS_WITH_JSON;K_EXPORT_PLASMA_DATAENGINE_WITH_JSON)
        list(APPEND CMAKE_AUTOMOC_DEPEND_FILTERS
            "${macro_name}"
            "[\n^][ \t]*${macro_name}[ \t\n]*\\([^,]*,[^,]*,[ \t\n]*\"([^\"]+)\""
        )
    endforeach()
endif()
####################################################################################

include("${CMAKE_CURRENT_LIST_DIR}/KF5PlasmaMacros.cmake")
