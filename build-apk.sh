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

APK_DIR="android/build/outputs/apk/release"
APK_UNSIGNED="$APK_DIR/android-release-unsigned.apk"
APK_ALIGNED="$APK_DIR/Unlucky-aligned.apk"
APK_SIGNED="$APK_DIR/Unlucky.apk"

# Locate zipalign and apksigner
if command -v zipalign >/dev/null 2>&1; then
  ZIPALIGN_BIN="$(command -v zipalign)"
else
  ZIPALIGN_BIN="${ANDROID_HOME:-$ANDROID_SDK_ROOT}/build-tools/*/zipalign"
fi
if command -v apksigner >/dev/null 2>&1; then
  APKSIGNER_BIN="$(command -v apksigner)"
else
  APKSIGNER_BIN="${ANDROID_HOME:-$ANDROID_SDK_ROOT}/build-tools/*/apksigner"
fi

# Check if build was successful
if [ -f "$APK_UNSIGNED" ]; then
    echo "✅ APK built successfully!"
    echo "📱 APK location: $APK_UNSIGNED"
    echo "📏 APK size: $(du -h "$APK_UNSIGNED" | cut -f1)"
    
    if [ "${1:-}" = "--sign" ]; then
        echo "🔐 Aligning and signing APK (debug key)..."
        if [ ! -f "keystore.jks" ]; then
            keytool -genkey -v -keystore keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias android -storepass android -keypass android -dname "CN=Android Debug,O=Android,C=US"
        fi
        # Align with page alignment
        eval "$ZIPALIGN_BIN" -v -p 4 "$APK_UNSIGNED" "$APK_ALIGNED"
        # Verify alignment
        eval "$ZIPALIGN_BIN" -c -v 4 "$APK_ALIGNED"
        # Sign with apksigner (preferred on modern SDKs)
        eval "$APKSIGNER_BIN" sign --ks keystore.jks --ks-pass pass:android --key-pass pass:android --out "$APK_SIGNED" "$APK_ALIGNED"
        # Verify signature
        eval "$APKSIGNER_BIN" verify -v "$APK_SIGNED"
        echo "✅ APK aligned and signed: $APK_SIGNED"
    fi
else
    echo "❌ APK build failed! Missing: $APK_UNSIGNED"
    exit 1
fi

echo "🎉 Build complete!"