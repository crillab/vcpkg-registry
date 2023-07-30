if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(STATIC "OFF")
else()
    set(STATIC "ON")
endif()

find_program(GIT git)

set(GIT_URL "https://github.com/kahypar/kahypar")
set(GIT_REV "c1efa28379c3c8ddc5df2ed24f30f42567190478")

if(NOT EXISTS "${DOWNLOADS}/kahypar")
    message(STATUS "Cloning...")
    vcpkg_execute_required_process(
        COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} "${DOWNLOADS}/kahypar"
        WORKING_DIRECTORY ${DOWNLOADS}
        LOGNAME clone
    )
endif()
message(STATUS "Cloning done")

vcpkg_execute_required_process(
    COMMAND ${GIT} pull
    WORKING_DIRECTORY ${DOWNLOADS}/kahypar
    LOGNAME pull
)

vcpkg_execute_required_process(
    COMMAND ${GIT} reset --hard ${GIT_REV}
    WORKING_DIRECTORY ${DOWNLOADS}/kahypar
    LOGNAME checkout
)

vcpkg_execute_required_process(
    COMMAND ${GIT} clean -fdx
    WORKING_DIRECTORY ${DOWNLOADS}/kahypar
    LOGNAME clean
)

vcpkg_execute_required_process(
    COMMAND ${GIT} apply ${CURRENT_PORT_DIR}/CMakeLists.txt.patch ${CURRENT_PORT_DIR}/lib/CMakeLists.txt.patch ${CURRENT_PORT_DIR}/cmake/variables.cmake.patch ${CURRENT_PORT_DIR}/cmake/docs-ci.cmake.patch ${CURRENT_PORT_DIR}/cmake/project-is-top-level.cmake.patch ${CURRENT_PORT_DIR}/cmake/lint-targets.cmake.patch ${CURRENT_PORT_DIR}/cmake/lint.cmake.patch ${CURRENT_PORT_DIR}/cmake/folders.cmake.patch ${CURRENT_PORT_DIR}/cmake/docs.cmake.patch ${CURRENT_PORT_DIR}/cmake/spell-targets.cmake.patch ${CURRENT_PORT_DIR}/cmake/install-rules.cmake.patch ${CURRENT_PORT_DIR}/cmake/dev-mode.cmake.patch ${CURRENT_PORT_DIR}/cmake/spell.cmake.patch ${CURRENT_PORT_DIR}/cmake/prelude.cmake.patch ${CURRENT_PORT_DIR}/cmake/install-config.cmake.patch ${CURRENT_PORT_DIR}/cmake/coverage.cmake.patch
    WORKING_DIRECTORY ${DOWNLOADS}/kahypar
    LOGNAME patch
)

# Set this variable to the name this project installs itself as, i.e. the name
# that you can use in a find_package(<name> REQUIRED) command call
set(name kahypar)

vcpkg_cmake_configure(
    SOURCE_PATH "${DOWNLOADS}/kahypar"
    OPTIONS -DBUILD_TESTING=OFF -DKAHYPAR_USE_MINIMAL_BOOST=ON
    # vcpkg wants CMake package config files in share, so if the project allows
    # changing the path, then we can do that here
    #
    # This option is based on the one provided by cmake-init, for other
    # projects not following best practices, please refer to their
    # documentation or their CMake scripts, or in a worst-case scenario, you
    # have to patch around the project's deficiencies
    #"-D${name}_INSTALL_CMAKEDIR=lib/share/${name}"
)

vcpkg_cmake_install()

# If the port's name and the CMake package's name are different, then we can
# pass the package name here, otherwise no arguments are necessary
# vcpkg_cmake_config_fixup(PACKAGE_NAME "${name}")

#vcpkg_cmake_config_fixup(CONFIG_PATH cmake)


# Remove files that aren't just the build artifacts and empty folders
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# vcpkg requires a license file to be installed as well
configure_file(
    "${DOWNLOADS}/kahypar/LICENSE.txt"
    "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
    COPYONLY
)