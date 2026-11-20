set(BUILD_SHARED_LIBS OFF)

set(SDLIMAGE_VENDORED ON)
set(SDLTTF_VENDORED ON)

add_subdirectory(SDL)
add_subdirectory(SDL_image)
add_subdirectory(SDL_ttf)