find_program(SIPS_EXECUTABLE sips REQUIRED)
find_program(ICONUTIL_EXECUTABLE iconutil REQUIRED)

set(ICON_PNG "${CMAKE_CURRENT_SOURCE_DIR}/resources/icons/icon.png")
set(ICONSET_DIR "${CMAKE_CURRENT_BINARY_DIR}/AppIcon.iconset")
set(APP_ICNS "${CMAKE_CURRENT_BINARY_DIR}/AppIcon.icns")

add_custom_command(
    OUTPUT "${APP_ICNS}"

    COMMAND ${CMAKE_COMMAND} -E make_directory "${ICONSET_DIR}"

    # 16x16 and 32x32
    COMMAND "${SIPS_EXECUTABLE}" -z 16 16 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_16x16.png"
    COMMAND "${SIPS_EXECUTABLE}" -z 32 32 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_16x16@2x.png"

    # 32x32 and 64x64
    COMMAND "${SIPS_EXECUTABLE}" -z 32 32 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_32x32.png"
    COMMAND "${SIPS_EXECUTABLE}" -z 64 64 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_32x32@2x.png"

    # 128x128 and 256x256
    COMMAND "${SIPS_EXECUTABLE}" -z 128 128 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_128x128.png"
    COMMAND "${SIPS_EXECUTABLE}" -z 256 256 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_128x128@2x.png"

    # 256x256 and 512x512
    COMMAND "${SIPS_EXECUTABLE}" -z 256 256 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_256x256.png"
    COMMAND "${SIPS_EXECUTABLE}" -z 512 512 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_256x256@2x.png"

    # 512x512 and 1024x1024
    COMMAND "${SIPS_EXECUTABLE}" -z 512 512 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_512x512.png"
    COMMAND "${SIPS_EXECUTABLE}" -z 1024 1024 "${ICON_PNG}" --out "${ICONSET_DIR}/icon_512x512@2x.png"

    COMMAND "${ICONUTIL_EXECUTABLE}" -c icns "${ICONSET_DIR}" -o "${APP_ICNS}"

    DEPENDS "${ICON_PNG}"
    COMMENT "Generating macOS application icon"
    VERBATIM
)

set_source_files_properties(
    "${APP_ICNS}" PROPERTIES
    GENERATED TRUE
    MACOSX_PACKAGE_LOCATION "Resources"
)

add_executable(translucent-sdl3 MACOSX_BUNDLE main.c)

target_sources(translucent-sdl3 PRIVATE "${APP_ICNS}")

set_target_properties(translucent-sdl3 PROPERTIES
    MACOSX_BUNDLE TRUE
    MACOSX_BUNDLE_ICON_FILE "AppIcon.icns"
    MACOSX_BUNDLE_GUI_IDENTIFIER "com.doni.translucent"
    MACOSX_BUNDLE_BUNDLE_NAME "Translucent"
    MACOSX_BUNDLE_BUNDLE_VERSION "${PROJECT_VERSION}"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
)