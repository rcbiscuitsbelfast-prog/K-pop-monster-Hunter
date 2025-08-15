#!/bin/bash

# Build APK script for K-pop Monster Hunter Remix (MIFF Movement)
# Public keystore, no secrets, no barriers to remixing!
set -euo pipefail

echo "🎮 Building K-pop Monster Hunter Remix Android APK..."
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
    echo "🎉 Build complete! Ready for rhythm-based monster hunting!"
    echo ""
    echo "📋 Installation:"
    echo "   1. Transfer APK to your Android 8.0+ device"
    echo "   2. Enable 'Install from unknown sources'"
    echo "   3. Install and enjoy! 🎵⚔️"
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