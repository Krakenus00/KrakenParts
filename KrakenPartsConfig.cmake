#[[

╔═════════════════════════════════════════════════════════════════════════════╗
║                    Copyright © 2022 Mykhailo Mushynskyi                     ║
╟─────────────────────────────────────────────────────────────────────────────╢
║  This work is licensed under a CeCILL Free Software License Agreement v2.1  ║
╚═════════════════════════════════════════════════════════════════════════════╝

]]

set(KrakenParts_SrcDir ${CMAKE_CURRENT_LIST_DIR}/Source)

# Including dependencies
if(Standalone)
    set(SDK_Type STATIC)
    include(${CMAKE_CURRENT_LIST_DIR}/Modules/MythSDK/MythSDKConfig.cmake)
endif()

set(KrakenCores_SrcDir ${KrakenParts_SrcDir}/KrakenCores)
set(DX11Core_Files
    ${KrakenCores_SrcDir}/DX11Core/DX11Core.cpp
    ${KrakenCores_SrcDir}/DX11Core/DX11Core.h
)

set(KrakenLibrary_SrcDir ${KrakenParts_SrcDir}/KrakenLibrary)
set(KrakenLibrary_Files
    ${KrakenLibrary_SrcDir}/KrakenPreset.cpp
    ${KrakenLibrary_SrcDir}/KrakenPreset.h
    ${KrakenLibrary_SrcDir}/IKrakenCore.h
    ${KrakenLibrary_SrcDir}/KrakenStatus.h
)

add_library(KrakenLibrary STATIC ${KrakenLibrary_Files})
set_target_properties(KrakenLibrary PROPERTIES
    FOLDER KrakenParts
)
include_sdk(KrakenLibrary)

function(include_krakenLibrary Target)
    target_link_libraries(${Target} KrakenLibrary)
    target_include_directories(${Target} PRIVATE ${KrakenLibrary_SrcDir})
endfunction()

add_library(DX11KrakenCore STATIC ${DX11Core_Files})
set_target_properties(DX11KrakenCore PROPERTIES
    FOLDER KrakenParts/KrakenCores
)
include_sdk(DX11KrakenCore)
include_krakenLibrary(DX11KrakenCore)

function(include_krakenCores Target)
    if(APPLE)
    elseif(_WIN32)
        target_link_libraries(${Target} DX11KrakenCore)
    endif()
    target_include_directories(${Target} PRIVATE ${KrakenCores_SrcDir})
endfunction()
