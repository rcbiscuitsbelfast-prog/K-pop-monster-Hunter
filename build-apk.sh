#!/bin/bash

# Build APK script for Unlucky game (modernized)
set -euo pipefail

echo "Building Unlucky Android APK..."

# Ensure gradlew is executable
chmod +x gradlew

# Display Java version for debugging
echo "Java version:"
java -version || true

# Clean previous builds
echo "Cleaning previous builds..."
./gradlew --no-daemon clean

# Build release APK
echo "Building release APK..."
./gradlew --no-daemon :android:assembleRelease

APK_UNSIGNED="android/build/outputs/apk/release/android-release-unsigned.apk"
APK_ALIGNED="android/build/outputs/apk/release/Unlucky.apk"

# Check if build was successful
if [ -f "$APK_UNSIGNED" ]; then
    echo "✅ APK built successfully!"
    echo "📱 APK location: $APK_UNSIGNED"
    echo "📏 APK size: $(du -h "$APK_UNSIGNED" | cut -f1)"
    
    if [ "${1:-}" = "--sign" ]; then
        echo "🔐 Signing APK (debug key)..."
        if [ ! -f "keystore.jks" ]; then
            keytool -genkey -v -keystore keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias android -storepass android -keypass android -dname "CN=Android Debug,O=Android,C=US"
        fi
        # Align
        "$ANDROID_HOME"/build-tools/*/zipalign -v 4 "$APK_UNSIGNED" "$APK_ALIGNED"
        # Sign with apksigner (preferred on modern SDKs)
        "$ANDROID_HOME"/build-tools/*/apksigner sign --ks keystore.jks --ks-pass pass:android --key-pass pass:android --out "$APK_ALIGNED" "$APK_ALIGNED"
        echo "✅ APK aligned and signed: $APK_ALIGNED"
    fi
else
    echo "❌ APK build failed!"
    exit 1
fi

echo "🎉 Build complete!"