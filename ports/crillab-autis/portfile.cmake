# Please see
# https://vcpkg.readthedocs.io/en/latest/maintainers/vcpkg_from_github/ for
# details on how to fill out the arguments
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO crillab/autis
    REF v0.1.6
    SHA512 b55ef3b1f4ab57b5b050a7befd3cade9ef97908264f114a8b9b934dd367cb7d6940e0a9afbcca62b93dcb7c2408c465f580884ce7bf2bb65328e6d6ab687eedd
    HEAD_REF main
)

# Set this variable to the name this project installs itself as, i.e. the name
# that you can use in a find_package(<name> REQUIRED) command call
set(name crillab-autis)

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
    "${SOURCE_PATH}/LICENSE.md"
    "${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright"
    COPYONLY
)