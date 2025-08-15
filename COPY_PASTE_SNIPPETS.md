# 📋 Copy-Paste Snippets for Remixers

## 🎯 Quick Setup Guide

Copy these snippets to implement the same MIFF movement CI/CD pipeline in your project!

## 🔑 1. Generate Public Keystore

```bash
# Create keystore directory
mkdir -p android/keystore

# Generate public keystore (replace with your project details)
keytool -genkey -v -keystore android/keystore/open-remix.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias remixkey -storepass remixpass -keypass remixpass \
  -dname "CN=Your Game Name,OU=MIFF Movement,O=Open Source,C=US"
```

## 📱 2. Android Build Configuration

### `android/build.gradle`
```gradle
android {
    buildToolsVersion "35.0.0"
    compileSdkVersion 35
    namespace "com.yourgame.main"

    defaultConfig {
        applicationId "com.yourgame.main"
        minSdkVersion 26  // Android 8.0+
        targetSdkVersion 35
        versionCode 1
        versionName "1.0.0"
    }
    
    signingConfigs {
        remix {
            storeFile file('../keystore/open-remix.keystore')
            storePassword 'remixpass'
            keyAlias 'remixkey'
            keyPassword 'remixpass'
        }
    }
    
    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-project.txt'
            signingConfig signingConfigs.remix
        }
        debug {
            signingConfig signingConfigs.remix
        }
    }
    
    lint {
        abortOnError false
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}
```

## 🤖 3. GitHub Actions Workflow

### `.github/workflows/auto-build-apk.yml`
```yaml
name: Auto-Build APK

on:
  push:
    branches: [ main, develop ]
    paths:
      - 'core/**'
      - 'android/**'
      - 'desktop/**'
      - 'build.gradle'
      - 'gradle.properties'
      - 'settings.gradle'
  pull_request:
    branches: [ main, develop ]
    paths:
      - 'core/**'
      - 'android/**'
      - 'desktop/**'
      - 'build.gradle'
      - 'gradle.properties'
      - 'settings.gradle'
  workflow_dispatch:
    inputs:
      build_type:
        description: 'Build type (debug/release)'
        required: true
        default: 'release'
        type: choice
        options:
          - debug
          - release

jobs:
  build-apk:
    name: Build and Sign APK
    runs-on: ubuntu-latest
    
    steps:
    - name: 🚀 Checkout code
      uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - name: 📱 Set up JDK 17
      uses: actions/setup-java@v4
      with:
        java-version: '17'
        distribution: 'temurin'
        cache: 'gradle'

    - name: 🤖 Set up Android SDK
      uses: android-actions/setup-android@v2
      with:
        api-level: '26'
        build-tools: '35.0.0'
        platform: '35'

    - name: 🔧 Make gradlew executable
      run: chmod +x gradlew

    - name: 📊 Display build info
      run: |
        echo "🎮 Building: Your Game Name"
        echo "📦 Version: $(grep 'version =' build.gradle | cut -d"'" -f2)"
        echo "🏗️  Build type: ${{ github.event.inputs.build_type || 'release' }}"
        echo "🔑 Using public keystore: android/keystore/open-remix.keystore"
        echo "📱 Target SDK: 35 (Android 14)"
        echo "📱 Min SDK: 26 (Android 8.0+)"

    - name: 🧹 Clean previous builds
      run: ./gradlew --no-daemon clean

    - name: 🔨 Build APK
      run: |
        if [ "${{ github.event.inputs.build_type || 'release' }}" = "debug" ]; then
          ./gradlew --no-daemon :android:assembleDebug
        else
          ./gradlew --no-daemon :android:assembleRelease
        fi

    - name: ✅ Verify APK build
      run: |
        if [ "${{ github.event.inputs.build_type || 'release' }}" = "debug" ]; then
          APK_PATH="android/build/outputs/apk/debug/android-debug.apk"
        else
          APK_PATH="android/build/outputs/apk/release/android-release.apk"
        fi
        
        if [ -f "$APK_PATH" ]; then
          echo "✅ APK built successfully!"
          echo "📱 APK location: $APK_PATH"
          echo "📏 APK size: $(du -h "$APK_PATH" | cut -f1)"
          echo "🔍 APK info:"
          aapt dump badging "$APK_PATH" | grep -E "(package|application-label|version)"
        else
          echo "❌ APK build failed!"
          exit 1
        fi

    - name: 📤 Upload APK as artifact
      uses: actions/upload-artifact@v4
      with:
        name: Your-Game-APK
        path: |
          android/build/outputs/apk/debug/android-debug.apk
          android/build/outputs/apk/release/android-release.apk
        retention-days: 90

    - name: 🏷️ Generate version info
      id: version_info
      run: |
        VERSION=$(grep 'version =' build.gradle | cut -d"'" -f2)
        COMMIT_SHA=$(git rev-parse --short HEAD)
        BUILD_DATE=$(date -u +'%Y-%m-%d %H:%M UTC')
        
        echo "version=$VERSION" >> $GITHUB_OUTPUT
        echo "commit_sha=$COMMIT_SHA" >> $GITHUB_OUTPUT
        echo "build_date=$BUILD_DATE" >> $GITHUB_OUTPUT

    - name: 📝 Create build summary
      if: github.event_name == 'push' && github.ref == 'refs/heads/main'
      run: |
        cat << EOF > build-summary.md
        # 🎮 Your Game Name - Build Summary
        
        ## 📱 APK Build Complete!
        
        **Version:** ${{ steps.version_info.outputs.version }}  
        **Commit:** ${{ steps.version_info.outputs.commit_sha }}  
        **Build Date:** ${{ steps.version_info.outputs.build_date }}  
        **Build Type:** ${{ github.event.inputs.build_type || 'release' }}
        
        ## 🚀 Installation Instructions
        
        1. **Download the APK** from the artifacts above
        2. **Enable "Install from unknown sources"** in your Android settings
        3. **Install the APK** on your Android 8.0+ device
        4. **Enjoy the game!** 🎮
        
        ## 🔧 For Remixers
        
        - **Keystore:** Publicly available at \`android/keystore/open-remix.keystore\`
        - **Alias:** \`remixkey\`
        - **Password:** \`remixpass\`
        - **Build Command:** \`./gradlew :android:assembleRelease\`
        
        ## 🎵 MIFF Movement
        
        This build is part of the **Make It For Free** movement - 
        empowering creators to build, share, and remix games without barriers!
        
        ---
        *Built with ❤️ by the open-source community*
        EOF

    - name: 📤 Upload build summary
      if: github.event_name == 'push' && github.ref == 'refs/heads/main'
      uses: actions/upload-artifact@v4
      with:
        name: Build-Summary
        path: build-summary.md
        retention-days: 90

  create-release:
    name: Create Release
    needs: build-apk
    if: github.event_name == 'push' && github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    
    steps:
    - name: 📥 Download APK artifacts
      uses: actions/download-artifact@v4
      with:
        name: Your-Game-APK
        path: ./apks

    - name: 📥 Download build summary
      uses: actions/download-artifact@v4
      with:
        name: Build-Summary
        path: ./

    - name: 🏷️ Create GitHub Release
      uses: softprops/action-gh-release@v2
      with:
        tag_name: v${{ needs.build-apk.outputs.version || '1.0.0' }}
        name: 🎮 Your Game Name v${{ needs.build-apk.outputs.version || '1.0.0' }}
        body_path: build-summary.md
        files: |
          apks/android-release.apk
          apks/android-debug.apk
        draft: false
        prerelease: false
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## 🚀 4. Build Scripts

### `build-apk.sh`
```bash
#!/bin/bash

# Build APK script for Your Game Name (MIFF Movement)
# Public keystore, no secrets, no barriers to remixing!
set -euo pipefail

echo "🎮 Building Your Game Name Android APK..."
echo "🎵 Part of the MIFF (Make It For Free) movement!"

# Ensure gradlew is executable
chmod +x gradlew

# Display Java version for debugging
echo "☕ Java version:"
java -version || true

# Clean previous builds
echo "🧹 Cleaning previous builds..."
./gradlew --no-daemon clean

# Build type selection
BUILD_TYPE="${1:-release}"
echo "🏗️  Building $BUILD_TYPE APK..."

if [ "$BUILD_TYPE" = "debug" ]; then
    ./gradlew --no-daemon :android:assembleDebug
    APK_PATH="android/build/outputs/apk/debug/android-debug.apk"
else
    ./gradlew --no-daemon :android:assembleRelease
    APK_PATH="android/build/outputs/apk/release/android-release.apk"
fi

# Check if build was successful
if [ -f "$APK_PATH" ]; then
    echo "✅ APK built successfully!"
    echo "📱 APK location: $APK_PATH"
    echo "📏 APK size: $(du -h "$APK_PATH" | cut -f1)"
    
    # Display APK info
    echo "🔍 APK details:"
    aapt dump badging "$APK_PATH" | grep -E "(package|application-label|version)" || true
    
    echo ""
    echo "🎉 Build complete! Ready to play!"
    echo ""
    echo "📋 Installation:"
    echo "   1. Transfer APK to your Android 8.0+ device"
    echo "   2. Enable 'Install from unknown sources'"
    echo "   3. Install and enjoy! 🎮"
    echo ""
    echo "🔧 For remixers:"
    echo "   - Keystore: android/keystore/open-remix.keystore"
    echo "   - Alias: remixkey"
    echo "   - Password: remixpass"
    echo "   - Build command: ./gradlew :android:assembleRelease"
else
    echo "❌ APK build failed!"
    exit 1
fi
```

### `mobile-build.sh`
```bash
#!/bin/bash

# Mobile Build Script for Your Game Name
# Optimized for Termux and mobile development environments
# Part of the MIFF (Make It For Free) movement

set -euo pipefail

echo "📱 Mobile Build Script for Your Game Name"
echo "🎵 MIFF Movement - Building games on mobile!"

# Check if we're in a mobile environment
if command -v termux-info >/dev/null 2>&1; then
    echo "✅ Detected Termux environment"
    MOBILE_ENV="termux"
elif [ -d "/data/data/com.termux" ]; then
    echo "✅ Detected Android environment"
    MOBILE_ENV="android"
else
    echo "⚠️  Not detected as mobile environment, but continuing..."
    MOBILE_ENV="unknown"
fi

# Check prerequisites
echo "🔍 Checking prerequisites..."

# Check Java
if command -v java >/dev/null 2>&1; then
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2)
    echo "✅ Java found: $JAVA_VERSION"
else
    echo "❌ Java not found. Installing..."
    if [ "$MOBILE_ENV" = "termux" ]; then
        pkg install openjdk-17 -y
    else
        echo "Please install Java 17 manually"
        exit 1
    fi
fi

# Check Gradle
if command -v gradle >/dev/null 2>&1; then
    GRADLE_VERSION=$(gradle --version | grep "Gradle" | head -n 1 | cut -d' ' -f2)
    echo "✅ Gradle found: $GRADLE_VERSION"
else
    echo "❌ Gradle not found. Installing..."
    if [ "$MOBILE_ENV" = "termux" ]; then
        pkg install gradle -y
    else
        echo "Please install Gradle manually"
        exit 1
    fi
fi

# Make gradlew executable
chmod +x gradlew

# Clean previous builds
echo "🧹 Cleaning previous builds..."
./gradlew --no-daemon clean

# Build APK
echo "🏗️  Building APK..."
./gradlew --no-daemon :android:assembleRelease

# Check if build was successful
APK_PATH="android/build/outputs/apk/release/android-release.apk"
if [ -f "$APK_PATH" ]; then
    echo "✅ APK built successfully!"
    echo "📱 APK location: $APK_PATH"
    echo "📏 APK size: $(du -h "$APK_PATH" | cut -f1)"
    
    echo ""
    echo "🎉 Mobile build complete!"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Transfer APK to your Android device"
    echo "   2. Enable 'Install from unknown sources'"
    echo "   3. Install and test the game"
    echo ""
    echo "🔧 Build info:"
    echo "   - Keystore: android/keystore/open-remix.keystore"
    echo "   - Alias: remixkey"
    echo "   - Password: remixpass"
    echo "   - Target: Android 8.0+ (API 26+)"
else
    echo "❌ APK build failed!"
    echo "🔍 Check the build logs above for errors"
    exit 1
fi

echo ""
echo "🎵 Happy remixing! Part of the MIFF movement."
```

## 📱 5. Android Manifest

### `android/AndroidManifest.xml`
```xml
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.yourgame.main"
    android:versionCode="1"
    android:versionName="1.0.0" >

    <application
        android:allowBackup="true"
        android:icon="@drawable/ic_launcher"
        android:label="@string/app_name"
        android:theme="@style/GdxTheme" >
        <activity
            android:name="com.yourgame.main.AndroidLauncher"
            android:label="@string/app_name" 
            android:screenOrientation="landscape"
            android:configChanges="keyboard|keyboardHidden|orientation|screenSize"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```

## 📚 6. README Template

### `README.md`
```markdown
# 🎮 Your Game Name

> **A description of your game, built for the MIFF (Make It For Free) movement**

[![Build Status](https://github.com/your-username/your-game/workflows/Auto-Build%20APK/badge.svg)](https://github.com/your-username/your-game/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![MIFF Movement](https://img.shields.io/badge/MIFF-Make%20It%20For%20Free-blue.svg)](https://makeitforfree.org)

## 🚀 Quick Start

### One-Command Build
```bash
# Clone and build
git clone https://github.com/your-username/your-game.git
cd your-game
./build-apk.sh
```

### Mobile Development (Termux)
```bash
# Install on Android device
pkg install openjdk-17 gradle git
git clone https://github.com/your-username/your-game.git
cd your-game
./mobile-build.sh
```

## 📱 Download

- **Latest APK**: [GitHub Actions Artifacts](https://github.com/your-username/your-game/actions)
- **Releases**: [GitHub Releases](https://github.com/your-username/your-game/releases)
- **Direct Build**: Run `./build-apk.sh` locally

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

## 🔄 Remixing

### Quick Remix
1. **Fork** the repository
2. **Clone** your fork
3. **Modify** gameplay or assets
4. **Push** changes (triggers auto-build)
5. **Share** your remix!

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

## 🎵 MIFF Movement

**Make It For Free** - Empowering creators to build, share, and remix games without barriers.

- **Website**: [Make It For Free](https://makeitforfree.org)
- **Principles**: Open source, no barriers, community-driven
- **Tools**: Public keystores, automatic builds, shared assets

---

**🎵 Let's make amazing games together, for free! 🎵**

*Part of the MIFF (Make It For Free) movement - empowering creators worldwide.*
```

## 🎯 7. Quick Setup Commands

```bash
# 1. Create keystore directory and generate keystore
mkdir -p android/keystore
keytool -genkey -v -keystore android/keystore/open-remix.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias remixkey -storepass remixpass -keypass remixpass \
  -dname "CN=Your Game Name,OU=MIFF Movement,O=Open Source,C=US"

# 2. Make build scripts executable
chmod +x build-apk.sh mobile-build.sh

# 3. Test the build
./build-apk.sh

# 4. Push to GitHub to trigger CI/CD
git add .
git commit -m "Add MIFF movement CI/CD pipeline"
git push origin main
```

## 🎉 That's It!

Your project now has:
- ✅ **Public keystore** for APK signing
- ✅ **Automatic builds** on every code change
- ✅ **Mobile development** support
- ✅ **Zero secrets** - everything is public
- ✅ **MIFF movement** principles implemented

**🎵 Happy remixing! 🎵**