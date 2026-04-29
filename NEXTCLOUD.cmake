# SPDX-FileCopyrightText: 2017 Nextcloud GmbH and Nextcloud contributors
# SPDX-FileCopyrightText: 2012 ownCloud GmbH
# SPDX-FileCopyrightText: 2026 Vida Design / Jacob McNeill
# SPDX-License-Identifier: GPL-2.0-or-later
#
# Vida Cloud — desktop client brand configuration.
# This file is the single source of truth for all OEM-replaceable strings.
#
# keep the application name and short name the same or different for dev and prod build
# or some migration logic will behave differently for each build
if(NEXTCLOUD_DEV)
    set( APPLICATION_NAME       "VidaCloudDev" )
    set( APPLICATION_SHORTNAME  "VidaCloudDev" )
    set( APPLICATION_EXECUTABLE "vidaclouddev" )
    set( APPLICATION_ICON_NAME  "VidaCloud" )
else()
    set( APPLICATION_NAME       "Vida Cloud" )
    set( APPLICATION_SHORTNAME  "VidaCloud" )
    set( APPLICATION_EXECUTABLE "vidacloud" )
    set( APPLICATION_ICON_NAME  "${APPLICATION_SHORTNAME}" )
endif()

set( APPLICATION_CONFIG_NAME "${APPLICATION_EXECUTABLE}" )
set( APPLICATION_DOMAIN     "vidatools.com" )
set( APPLICATION_VENDOR     "Vida Design" )
set( APPLICATION_UPDATE_URL "https://updates.vidatools.com/client/" CACHE STRING "URL for updater" )
set( APPLICATION_HELP_URL   "https://vidatools.com/help/cloud/" CACHE STRING "URL for the help menu" )

if(APPLE AND APPLICATION_NAME STREQUAL "Vida Cloud" AND EXISTS "${CMAKE_SOURCE_DIR}/theme/colored/Nextcloud-macOS-icon.svg")
    set( APPLICATION_ICON_NAME "VidaCloud-macOS" )
    message("Using macOS-specific application icon: ${APPLICATION_ICON_NAME}")
endif()

set( APPLICATION_ICON_SET   "SVG" )
# Pre-fill (and lock) the server URL so end-users never have to type it.
set( APPLICATION_SERVER_URL "https://vidatools.com/cloud" CACHE STRING "URL for the server to use. If entered, the UI field will be pre-filled with it" )
set( APPLICATION_SERVER_URL_ENFORCE ON ) # Lock the client to the Vida Cloud server only
set( APPLICATION_REV_DOMAIN "com.vidatools.cloud.desktop" )
# Replace with your Apple Developer Team ID before signing macOS builds.
set( DEVELOPMENT_TEAM "REPLACE_WITH_VIDA_APPLE_TEAM_ID" CACHE STRING "Apple Development Team ID" )
set( APPLICATION_VIRTUALFILE_SUFFIX "vidacloud" CACHE STRING "Virtual file suffix (not including the .)")
set( APPLICATION_OCSP_STAPLING_ENABLED OFF )
set( APPLICATION_FORBID_BAD_SSL OFF )

set( LINUX_PACKAGE_SHORTNAME "vidacloud" )
set( LINUX_APPLICATION_ID "${APPLICATION_REV_DOMAIN}")

set( THEME_CLASS            "NextcloudTheme" )
set( WIN_SETUP_BITMAP_PATH  "${CMAKE_SOURCE_DIR}/admin/win/nsi" )

set( MAC_INSTALLER_BACKGROUND_FILE "${CMAKE_SOURCE_DIR}/admin/osx/installer-background.png" CACHE STRING "The MacOSX installer background image")

# set( THEME_INCLUDE          "${OEM_THEME_DIR}/mytheme.h" )
# set( APPLICATION_LICENSE    "${OEM_THEME_DIR}/license.txt )

## Updater options
option( BUILD_UPDATER "Build updater" ON )

option( WITH_PROVIDERS "Build with providers list" ON )

option( ENFORCE_VIRTUAL_FILES_SYNC_FOLDER "Enforce use of virtual files sync folder when available" OFF )
option( DISABLE_VIRTUAL_FILES_SYNC_FOLDER "Disable use of virtual files sync folder even when available" OFF )

option(ENFORCE_SINGLE_ACCOUNT "Enforce use of a single account in desktop client" OFF)

option( DO_NOT_USE_PROXY "Do not use system wide proxy, instead always do a direct connection to server" OFF )

option( WIN_DISABLE_USERNAME_PREFILL "Do not prefill the Windows user name when creating a new account" OFF )

## Theming — Vida sage primary
set(NEXTCLOUD_BACKGROUND_COLOR "#6B8F71" CACHE STRING "Default Vida Cloud background color (sage)")
set( APPLICATION_WIZARD_HEADER_BACKGROUND_COLOR ${NEXTCLOUD_BACKGROUND_COLOR} CACHE STRING "Hex color of the wizard header background")
set( APPLICATION_WIZARD_HEADER_TITLE_COLOR "#ffffff" CACHE STRING "Hex color of the text in the wizard header")
option( APPLICATION_WIZARD_USE_CUSTOM_LOGO "Use the logo from ':/client/theme/colored/wizard_logo.(png|svg)' else the default application icon is used" ON )

#
## Windows Shell Extensions & MSI
## Vida-specific GUIDs (generated 2026-04-29) — do NOT reuse Nextcloud's GUIDs
## or installer collisions will brick existing Nextcloud client installs.
#
if(WIN32)
    # Context Menu
    set( WIN_SHELLEXT_CONTEXT_MENU_GUID      "{880843ED-EF33-4A67-A11F-E8C7990233A1}" )

    # Overlays
    set( WIN_SHELLEXT_OVERLAY_GUID_ERROR     "{0F23660F-1A8E-4411-80F4-41573B6CA063}" )
    set( WIN_SHELLEXT_OVERLAY_GUID_OK        "{25911371-A38D-47CC-BE2B-EC17B2D5A84D}" )
    set( WIN_SHELLEXT_OVERLAY_GUID_OK_SHARED "{BFF7A028-AC91-4FFD-990D-2B51418DC417}" )
    set( WIN_SHELLEXT_OVERLAY_GUID_SYNC      "{7277B053-D36C-4B5F-9A3C-E841B5CF015B}" )
    set( WIN_SHELLEXT_OVERLAY_GUID_WARNING   "{C2DED052-E2C2-4021-8A04-E2C100DADFE2}" )

    # MSI Upgrade Code (without brackets)
    set( WIN_MSI_UPGRADE_CODE                "E47D74AA-33DF-4D7B-B4C2-3794E908658D" )

    # Windows build options
    option( BUILD_WIN_MSI "Build MSI scripts and helper DLL" OFF )
    option( BUILD_WIN_TOOLS "Build Win32 migration tools" OFF )
endif()

if (APPLE AND CMAKE_OSX_DEPLOYMENT_TARGET VERSION_GREATER_EQUAL 11.0)
    option( BUILD_FILE_PROVIDER_MODULE "Build the macOS virtual files File Provider module" OFF )
endif()
