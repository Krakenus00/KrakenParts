#[[

╔═════════════════════════════════════════════════════════════════════════════╗
║                    Copyright © 2022 Mykhailo Mushynskyi                     ║
╟─────────────────────────────────────────────────────────────────────────────╢
║  This work is licensed under a CeCILL Free Software License Agreement v2.1  ║
╚═════════════════════════════════════════════════════════════════════════════╝

]]

# Source path
set(KrakenParts_SrcDir ${CMAKE_CURRENT_LIST_DIR}/Source)

# Including dependencies
if(Standalone)
    set(SDK_Type STATIC)
    include(${CMAKE_CURRENT_LIST_DIR}/Modules/MythSDK/MythSDKConfig.cmake)
endif()

# Cores' files
set(KrakenCores_SrcDir ${KrakenParts_SrcDir}/KrakenCores)
set(DX11Core_Files
    ${KrakenCores_SrcDir}/DX11Core/DX11Core.cpp
    ${KrakenCores_SrcDir}/DX11Core/DX11Core.h
)

# Include files
set(Kraken_IncDir ${KrakenParts_SrcDir}/Include)
set(Kraken_Includes
    ${Kraken_IncDir}/KrakenPreset.h
    ${Kraken_IncDir}/IKrakenCore.h
)

# Create DX11KrakenCore target
add_library(DX11KrakenCore STATIC ${DX11Core_Files})
set_target_properties(DX11KrakenCore PROPERTIES
    FOLDER KrakenParts/KrakenCores
)
include_sdk(DX11KrakenCore)

# Helper function to link KrakenParts
function(include_krakenParts Target)
    if(APPLE)
    elseif(WIN32)
        target_link_libraries(${Target} DX11KrakenCore)
    endif()
    target_include_directories(${Target} PRIVATE
        ${KrakenCores_SrcDir}
        ${Kraken_IncDir}
    )
endfunction()
