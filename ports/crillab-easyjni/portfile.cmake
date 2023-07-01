# Please see
# https://vcpkg.readthedocs.io/en/latest/maintainers/vcpkg_from_github/ for
# details on how to fill out the arguments
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO crillab/easyjni
REF v0.1.1
SHA512 8aa6a08d1ae5cb22db9d628937a166baf9aba66f83e82f13df6f56b4b3edb1aa2ad7833219c39259d52ccafdb23b99ccd58de04c7e0f883d78f2f81d4f09157e
    HEAD_REF main
)

# Set this variable to the name this project installs itself as, i.e. the name
# that you can use in a find_package(<name> REQUIRED) command call
set(name crillab-easyjni)

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