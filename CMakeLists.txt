cmake_minimum_required(VERSION 3.10.0)
project(translucent VERSION 0.1.0 LANGUAGES C)

add_subdirectory(external)
add_subdirectory(resources)

if(APPLE)
    include(cmake/macos.cmake)
elseif(WIN32)
    add_executable(translucent-sdl3 WIN32 main.c)
else()
    add_executable(translucent-sdl3 main.c)
endif()

target_link_libraries(
    translucent-sdl3
    translucent-resources
    SDL3::SDL3
    SDL3_image::SDL3_image
    SDL3_ttf::SDL3_ttf)