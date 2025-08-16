# 🎮 K-pop Monster Hunter Remix

> **A 2D action-platformer with rhythm-based combat, built for the MIFF (Make It For Free) movement**

[![Build Status](https://github.com/your-username/kpop-monster-hunter-remix/workflows/Auto-Build%20K-pop%20Monster%20Hunter%20Remix%20APK/badge.svg)](https://github.com/your-username/kpop-monster-hunter-remix/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MIFF Movement](https://img.shields.io/badge/MIFF-Make%20It%20For%20Free-blue.svg)](https://makeitforfree.org)

## 🚀 **Build Status: LOCAL BUILD SUCCESSFUL** ✅

**Latest Local Build**: ✅ **SUCCESS** (August 16, 2024)  
**APK Status**: 🔨 **Built Locally - Ready for Distribution**  
**Build Size**: 📱 **8.5 MB**  
**Features**: 🆕 **K-Pop Monster Hunter v1.0.0** with modern font and updated branding

> **📝 Note**: This APK was built locally and is ready for distribution. GitHub Actions artifacts are not currently available, but you can build your own APK using the build scripts provided.

## 🎵 About

**K-pop Monster Hunter Remix** is an open-source 2D action-platformer that combines rhythm-based combat with monster hunting mechanics. Built on the LibGDX framework, it demonstrates how to create fully remixable games with automatic CI/CD, public keystores, and zero barriers to contribution.

### 🌟 Features

- **🎵 Rhythm-Based Combat**: Time your attacks to the beat for maximum damage
- **⚔️ Monster Hunting**: Battle various creatures with unique patterns
- **📱 Mobile-First**: Optimized for Android 8.0+ devices
- **🔄 Fully Remixable**: Open source code and assets under MIT license
- **🤖 Auto-Build**: GitHub Actions automatically builds APKs on every change
- **🔑 Public Keystore**: No secrets, no manual signing required

## 🚀 Quick Start

### One-Command Build
```bash
# Clone and build
git clone https://github.com/your-username/kpop-monster-hunter-remix.git
cd kpop-monster-hunter-remix
./build-apk.sh
```

### Mobile Development (Termux)
```bash
# Install on Android device
pkg install openjdk-17 gradle git
git clone https://github.com/your-username/kpop-monster-hunter-remix.git
cd kpop-monster-hunter-remix
./mobile-build.sh
```

### 🎯 **Local Build Available**
**APK built successfully!** The latest APK is ready for distribution:
- **📱 APK File**: `android-release.apk` (8.5 MB)
- **🔧 Build Type**: Release (signed, optimized)
- **📅 Fresh Build**: Just built with all latest updates
- **📤 Distribution**: Transfer APK to your device or share with others

## 📱 Download

### 🚀 **Latest APK Versions**

#### **Release Build (Recommended)**
- **📱 APK File**: `android-release.apk` (8.5 MB)
- **🔧 Build Type**: Release (signed, optimized)
- **📅 Build Date**: Latest local build from source
- **✅ Status**: Built locally - ready for distribution

#### **Debug Build (Development)**
- **🐛 APK File**: `android-debug.apk` (if available)
- **🔧 Build Type**: Debug (unsigned, for testing)
- **📅 Build Date**: Latest debug build

### 📥 **Get the APK**

- **🔨 Local Build**: Run `./build-apk.sh` to build your own APK
- **📱 Transfer APK**: Copy the built APK to your device
- **🤖 GitHub Actions**: [Build Artifacts](https://github.com/your-username/kpop-monster-hunter-remix/actions) (when available)
- **🏷️ GitHub Releases**: [Official Releases](https://github.com/your-username/kpop-monster-hunter-remix/releases) (when available)

### 📋 **Installation Instructions**

1. **Build or Get APK**: 
   - **Option A**: Build locally with `./build-apk.sh`
   - **Option B**: Get from someone who has built it
   - **Option C**: Wait for GitHub Actions artifacts (when available)
2. **Transfer** the APK file to your Android device
3. **Enable** "Install from unknown sources" in device settings
4. **Install** the APK file
5. **Launch** "K-Pop Monster Hunter" from your app drawer

### 🆕 **Latest Version Features**

**Version**: 1.0.0 (Build: Latest)
**What's New**:
- 🎮 **Game Name**: Updated from "Unlucky" to "K-Pop Monster Hunter"
- 🔤 **Modern Font**: New DejaVuSans-Bold font for better readability
- 🎨 **UI Updates**: Refreshed text and interface elements
- 📱 **Android 8.0+**: Optimized for modern Android devices
- 🔑 **Public Keystore**: No secrets, fully remixable

**System Requirements**:
- **Android**: 8.0 (API 26) or higher
- **RAM**: 2GB minimum
- **Storage**: 50MB free space
- **Permissions**: Storage access for game saves

## 🎯 MIFF Movement

This project is part of the **Make It For Free** movement, demonstrating:

- ✅ **Public Keystore**: `android/keystore/open-remix.keystore`
- ✅ **No Secrets**: Everything committed to repository
- ✅ **Auto-Build**: CI/CD on every code change
- ✅ **Mobile-Friendly**: Works on Termux and mobile devices
- ✅ **Fully Remixable**: MIT license, open assets

## 🔧 Build System

### Public Keystore Details
- **Location**: `android/keystore/open-remix.keystore`
- **Alias**: `remixkey`
- **Password**: `remixpass`
- **No secrets required** - everything is public!

### Build Commands
```bash
# Release build (recommended)
./gradlew :android:assembleRelease

# Debug build (faster development)
./gradlew :android:assembleDebug

# Clean build
./gradlew clean

# Install on connected device
./gradlew :android:installDebug
```

## 🤖 CI/CD Pipeline

The project automatically builds APKs on every push to:
- `core/` (gameplay logic)
- `android/` (Android-specific code)
- `desktop/` (desktop version)
- Build configuration files

### Workflow Features
- 🚀 **Automatic APK building** on code changes
- 🔑 **Public keystore signing** (no secrets needed)
- 📤 **Artifact upload** for easy download
- 🏷️ **GitHub Releases** for main branch builds
- ✅ **Build verification** and APK info display

## 🎨 Game Architecture

### Modular Design
```
├── core/           # Platform-agnostic game logic
├── android/        # Android-specific implementation
├── desktop/        # Desktop version for development
└── assets/         # Shared game resources
```

### Key Components
- **Rhythm Engine**: Beat detection and timing
- **Combat System**: Monster hunting mechanics
- **Audio System**: K-pop music integration
- **UI Framework**: Responsive mobile interface

## 🎵 Asset Guidelines

### Ethical Asset Sourcing
This project follows MIFF principles:

#### ✅ Recommended
- **Creative Commons** licensed assets
- **Public domain** materials
- **Original creations** by contributors
- **Open source** game assets
- **Royalty-free** music and sound effects

#### ❌ Avoid
- **Copyrighted** K-pop music without permission
- **Proprietary** assets or engines
- **Non-commercial** only licenses

## 🔄 Remixing

### Quick Remix
1. **Fork** the repository
2. **Clone** your fork
3. **Modify** gameplay or assets
4. **Push** changes (triggers auto-build)
5. **Share** your remix!

### Remix Ideas
- New K-pop genres (J-pop, C-pop, etc.)
- Different monster types and behaviors
- Alternative rhythm mechanics
- Visual style variations
- Multiplayer features

## 📚 Documentation

- **[Remix Guide](REMIX_GUIDE.md)**: Comprehensive guide for contributors
- **[Build Scripts](build-apk.sh)**: Automated build process
- **[Mobile Development](mobile-build.sh)**: Termux and mobile setup
- **[GitHub Actions](.github/workflows/)**: CI/CD configuration

## 🛠️ Development

### Prerequisites
- **Android Studio** or **Android SDK** (API 26+)
- **Java 17** (OpenJDK/Temurin recommended)
- **Git** for version control

### Setup
```bash
# Clone repository
git clone https://github.com/your-username/kpop-monster-hunter-remix.git
cd kpop-monster-hunter-remix

# Build APK
./build-apk.sh

# Or use Gradle directly
./gradlew :android:assembleRelease
```

### Debugging
```bash
# View build logs
./gradlew :android:assembleDebug --info

# Check APK contents
aapt dump badging android-debug.apk

# Install and run on device
./gradlew :android:installDebug
```

## 🚀 **Current Build & APK Status**

### 📱 **Latest APK Built Locally**
**Status**: ✅ **LOCAL BUILD SUCCESSFUL**  
**APK File**: `android-release.apk`  
**Size**: 8.5 MB  
**Build Date**: August 16, 2024  
**Features**: K-Pop Monster Hunter v1.0.0 with modern updates

### 🔄 **Build Workflow**
1. **Code Changes** → Push to repository
2. **Auto-Build** → GitHub Actions builds APK
3. **APK Ready** → Download from Actions tab
4. **Local Build** → Use `./build-apk.sh` for custom builds

### 📥 **Get the Latest APK**
- **🔨 Build Locally**: Run `./build-apk.sh` in your environment
- **📱 Transfer APK**: Copy the built APK to your device
- **🤖 GitHub Actions**: [Latest Build Artifacts](https://github.com/your-username/kpop-monster-hunter-remix/actions) (when available)

### 🆕 **What's New in This Build**
- **Game Name**: Updated to "K-Pop Monster Hunter"
- **Modern Font**: DejaVuSans-Bold for better readability
- **UI Updates**: Refreshed text and branding
- **Android 8.0+**: Optimized for modern devices

## 🤝 Contributing

### Guidelines
- **MIT License** - all contributions must be MIT licensed
- **No secrets** - everything must be public and remixable
- **Mobile-first** - prioritize Android compatibility
- **Documentation** - explain your changes clearly
- **Testing** - ensure builds work on real devices

### Ways to Contribute
- 🎮 **Gameplay**: Add new mechanics or features
- 🎨 **Assets**: Create graphics, music, or sound effects
- 🐛 **Bug Fixes**: Report and fix issues
- 📚 **Documentation**: Improve guides and tutorials
- 🔧 **Build System**: Enhance CI/CD pipeline

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

All assets and code are free to use, modify, and distribute according to the MIT License terms.

## 🎵 MIFF Movement

**Make It For Free** - Empowering creators to build, share, and remix games without barriers.

- **Website**: [Make It For Free](https://makeitforfree.org)
- **Principles**: Open source, no barriers, community-driven
- **Tools**: Public keystores, automatic builds, shared assets

---

**🎵 Let's make amazing games together, for free! 🎵**

*Part of the MIFF (Make It For Free) movement - empowering creators worldwide.*
