# header-only library

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO p-ranav/argparse
    REF 557948f1236db9e27089959de837cc23de6c6bbd
    SHA512 c372f81622c696bb1071cb446397bea42e8db4d4a272be6ce6a6ef332130d801cb1f71e8a169167f26c0e1f7af2b8817c39f1db2f579c663d2950d6048e38b17
    HEAD_REF master
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        -DARGPARSE_BUILD_TESTS=OFF
)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/${PORT})

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug" "${CURRENT_PACKAGES_DIR}/lib")

# Handle copyright
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright COPYONLY)
