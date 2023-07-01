# Please see
# https://vcpkg.readthedocs.io/en/latest/maintainers/vcpkg_from_github/ for
# details on how to fill out the arguments
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO xcsp3team/XCSP3-CPP-Parser
    REF 7d4322a94f3465732940f9a1662fbc6565a1fc41
    SHA512 d5432d8a76d62618578ab9d8e3e5a1c165f3e2b28bdd9916d18be5e8e7467eb44dc0e8de7d66eca1b4f23dc339085f71cec1b44986734e029dd9a97f818ff769
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
        include/XCSP3Manager.h.patch
        include/XCSP3TreeNode.h.patch
        include/XCSP3CoreParser.h.patch
        CMakeLists.txt.patch
        src/XCSP3CoreParser.cc.patch
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