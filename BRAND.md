# Vida Cloud — Desktop Client Brand Status

Fork of [`nextcloud/desktop`](https://github.com/nextcloud/desktop) (GPL-2.0-or-later) rebranded to Vida Cloud. This is the Mac/Windows/Linux sync client.

## What's done

All brand-replaceable strings, IDs, and theme colors live in [`NEXTCLOUD.cmake`](NEXTCLOUD.cmake) and are already set:

- `APPLICATION_NAME` = `Vida Cloud` / shortname `VidaCloud`
- `APPLICATION_DOMAIN` = `vidatools.com`
- `APPLICATION_VENDOR` = `Vida Design`
- `APPLICATION_REV_DOMAIN` = `com.vidatools.cloud.desktop`
- `LINUX_APPLICATION_ID` = `com.vidatools.cloud.desktop`
- `APPLICATION_SERVER_URL` = `https://vidatools.com/cloud` (locked via `APPLICATION_SERVER_URL_ENFORCE ON` — the client can only sync against Vida Cloud)
- `APPLICATION_VIRTUALFILE_SUFFIX` = `vidacloud` (sync placeholder file extension)
- `NEXTCLOUD_BACKGROUND_COLOR` = `#6B8F71` (Vida sage)
- All 6 Windows shell-extension GUIDs regenerated 2026-04-29 — these are unique to Vida and won't collide with Nextcloud installs on the same machine.

## What's still needed before first release

### Apple (covers macOS desktop AND iOS)
1. **Apple Developer Program membership** ($99/yr) — register under "Vida Design" or your existing personal team
2. **Apple Team ID** — replace `REPLACE_WITH_VIDA_APPLE_TEAM_ID` at [`NEXTCLOUD.cmake:42`](NEXTCLOUD.cmake)
3. **Developer ID Application certificate** + **Developer ID Installer certificate** — install on the build machine
4. **Notary credentials** — App Store Connect API key (for `notarytool`)

### Windows
5. **Code-signing certificate** — strongly recommend EV (~$400/yr from DigiCert/Sectigo). Without EV, SmartScreen will scare users on every new release for ~2 weeks.

### Brand assets (replace placeholder Nextcloud icons)
The current icons under `theme/colored/` are still Nextcloud's blue swirl. Replace these with Vida Cloud logos:

| File | Used for |
|---|---|
| `theme/colored/Nextcloud-icon.svg` | Generic app icon (Linux, fallback) |
| `theme/colored/Nextcloud-icon-square.svg` | Square variant |
| `theme/colored/Nextcloud-macOS-icon.svg` | macOS dock icon (squircle) |
| `theme/colored/Nextcloud-macOS-sidebar.svg` | macOS Finder sidebar (template) |
| `theme/colored/Nextcloud-w10starttile.png` | Windows 10/11 start-menu tile (150×150) |
| `theme/colored/Nextcloud-w10startmenu.svg` | Windows start-menu vector |
| `theme/colored/wizard_logo.svg` (+ .png + @2x.png) | Login wizard hero logo |
| `theme/colored/wizard-nextcloud.svg` | Login wizard "what is Nextcloud" panel — replace with "what is Vida Cloud" panel |
| `theme/colored/wizard-files.svg`, `wizard-talk.svg`, `wizard-groupware.svg` | Login wizard onboarding panels |
| `admin/win/nsi/installer.ico` | Windows installer icon |
| `admin/osx/installer-background.png`, `DMGBackground.png` | macOS installer chrome |
| `theme/nextcloud.VisualElementsManifest.xml` | Windows 10 start-tile metadata (rename + edit) |

**One master asset is enough**: a 1024×1024 SVG/PNG of the Vida Cloud logo. From that we can generate every file above with ImageMagick + svgtopng.

### Optional but recommended
6. **Update server** — set `APPLICATION_UPDATE_URL` to a real updates JSON feed (we'll host this on `updates.vidatools.com`).
7. **Help URL** — currently points to `vidatools.com/help/cloud/`; create that page.

## Build flow (Linux, no signing — works today once assets land)

```bash
sudo apt install build-essential cmake qt6-base-dev qt6-tools-dev qt6-quickcontrols2 \
  qt6-svg-dev libssl-dev zlib1g-dev libsqlite3-dev libxml2-dev libcloudproviders-dev
mkdir build && cd build
cmake -DBUILD_UPDATER=OFF -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc)
admin/linux/build-appimage.sh
```

The AppImage drops in `build/bin/Vida_Cloud-x86_64.AppImage` — give it to Linux users directly, no signing needed.

## License

GPL-2.0-or-later. We must keep source available — this fork at `https://github.com/gandfrey/vida-cloud-desktop` satisfies that. Original Nextcloud copyright is preserved in every source file we didn't rewrite.

## Upstream sync

Pull updates from upstream Nextcloud as needed:

```bash
git remote add upstream https://github.com/nextcloud/desktop.git
git fetch upstream
git merge upstream/master --no-edit  # may have conflicts in NEXTCLOUD.cmake
```

The brand strings only live in 3 files (`NEXTCLOUD.cmake`, the icons under `theme/colored/`, and the DMG/installer chrome) — merges should be quick if upstream doesn't restructure those.
