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
    REF 4b429dc729bdfd1fe98873c5602927ceb88aabdd
    SHA512 40fde68fe32f5d9835b42f9d69040778f93dd9e5833b0c39fe26b503fdd6d2ae38df2140435274486bbd4424a97461b364dca0ff4c3216a14f6b7b016c9c8159
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
