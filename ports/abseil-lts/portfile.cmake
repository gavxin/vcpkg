include(vcpkg_common_functions)

if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "Abseil currently only supports being built for desktop")
endif()

if (VCPKG_LIBRARY_LINKAGE STREQUAL "dynamic")
    message("Abseil only supports static library linkage. Building static.")
    set(VCPKG_LIBRARY_LINKAGE static)
endif()

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO gavxin/abseil-cpp
    REF d5a5e1ed6ffb66030e304796003d659f6f9551ea
    SHA512 3d2eff66eb742cd86b5ee59f348ed76d46d15be363c5f9241ae1d58690c93795134c05bad0dde006321a23ece91d93a2e73a0aa310113f5cffb3cf0e3d9987ad
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets(CONFIG_PATH share/abseil-lts TARGET_PATH share/abseil-lts)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

vcpkg_copy_pdbs()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/abseil-lts RENAME copyright)
