# Please see
# https://vcpkg.readthedocs.io/en/latest/maintainers/vcpkg_from_github/ for
# details on how to fill out the arguments
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xcsp3team/XCSP3-CPP-Parser
    REF V1.5
    SHA512 ef449362ffcc593f713766611d30a5400428ee3b86adde902de4865977d31d591af88f6ce78b5e3c57b284349d695f3a966d0cd5d6c813a2563d2de51c5bfcec
    HEAD_REF master
    PATCHES
        cmake/variables.cmake.patch
        cmake/docs-ci.cmake.patch
        cmake/project-is-top-level.cmake.patch
        cmake/lint-targets.cmake.patch
        cmake/lint.cmake.patch
        cmake/folders.cmake.patch
        cmake/docs.cmake.patch
        cmake/spell-targets.cmake.patch
        cmake/install-rules.cmake.patch
        cmake/dev-mode.cmake.patch
        cmake/spell.cmake.patch
        cmake/prelude.cmake.patch
        cmake/install-config.cmake.patch
        cmake/coverage.cmake.patch
        CMakePresets.json.patch
        CMakeLists.txt.patch
)

# Set this variable to the name this project installs itself as, i.e. the name
# that you can use in a find_package(<name> REQUIRED) command call
set(name xcsp3-cpp-parser)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
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
    "${SOURCE_PATH}/LICENSE"
    "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
    COPYONLY
)