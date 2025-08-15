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

# Resolve zipalign and apksigner to a single binary path
if command -v zipalign >/dev/null 2>&1; then
  ZIPALIGN_BIN="$(command -v zipalign)"
else
  ZIPALIGN_BIN="$(ls -1d "${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"/build-tools/*/zipalign 2>/dev/null | sort -V | tail -n 1 || true)"
fi
if [ -z "${ZIPALIGN_BIN:-}" ] || [ ! -x "$ZIPALIGN_BIN" ]; then
  echo "❌ zipalign not found. Ensure Android build-tools are installed and on PATH."
  exit 2
fi

if command -v apksigner >/dev/null 2>&1; then
  APKSIGNER_BIN="$(command -v apksigner)"
else
  APKSIGNER_BIN="$(ls -1d "${ANDROID_HOME:-${ANDROID_SDK_ROOT:-}}"/build-tools/*/apksigner 2>/dev/null | sort -V | tail -n 1 || true)"
fi
if [ -z "${APKSIGNER_BIN:-}" ] || [ ! -x "$APKSIGNER_BIN" ]; then
  echo "❌ apksigner not found. Ensure Android build-tools are installed and on PATH."
  exit 2
fi

# Check if build was successful
if [ ! -f "$APK_UNSIGNED" ]; then
    echo "❌ APK build failed! Missing input APK: $APK_UNSIGNED"
    ls -la "$APK_DIR" || true
    exit 1
fi

echo "✅ APK built successfully!"
echo "📱 APK location: $APK_UNSIGNED"
echo "📏 APK size: $(du -h "$APK_UNSIGNED" | cut -f1)"

if [ "${1:-}" = "--sign" ]; then
    echo "🔐 Aligning and signing APK..."
    KEY_ALIAS="${KEY_ALIAS:-kpopmonsterhunter}"
    KEYSTORE_PATH="${KEYSTORE_PATH:-keystore.jks}"
    KEYSTORE_PASS="${KEYSTORE_PASSWORD:-android}"
    KEY_PASS="${KEY_PASSWORD:-$KEYSTORE_PASS}"

    # Ensure keystore and alias exist (skip generation if alias already present)
    if [ -f "$KEYSTORE_PATH" ]; then
        if keytool -list -v -keystore "$KEYSTORE_PATH" -storepass "$KEYSTORE_PASS" | grep -q "Alias name: $KEY_ALIAS"; then
            echo "Keystore exists and alias '$KEY_ALIAS' found. Skipping key generation."
        else
            echo "Keystore exists but alias '$KEY_ALIAS' missing. Generating new key alias."
            keytool -genkeypair -v -keystore "$KEYSTORE_PATH" -storepass "$KEYSTORE_PASS" \
                -keyalg RSA -keysize 2048 -validity 10000 -alias "$KEY_ALIAS" -keypass "$KEY_PASS" \
                -dname "CN=Android,O=Android,C=US"
        fi
    else
        echo "Creating new keystore with alias '$KEY_ALIAS'..."
        keytool -genkeypair -v -keystore "$KEYSTORE_PATH" -storepass "$KEYSTORE_PASS" \
            -keyalg RSA -keysize 2048 -validity 10000 -alias "$KEY_ALIAS" -keypass "$KEY_PASS" \
            -dname "CN=Android,O=Android,C=US"
    fi

    # Align with page alignment
    "$ZIPALIGN_BIN" -v -p 4 "$APK_UNSIGNED" "$APK_ALIGNED"
    # Verify alignment
    "$ZIPALIGN_BIN" -c -v 4 "$APK_ALIGNED"
    # Sign with apksigner (explicit alias)
    "$APKSIGNER_BIN" sign --ks "$KEYSTORE_PATH" --ks-key-alias "$KEY_ALIAS" \
        --ks-pass pass:"$KEYSTORE_PASS" --key-pass pass:"$KEY_PASS" \
        --out "$APK_SIGNED" "$APK_ALIGNED"
    # Verify signature
    "$APKSIGNER_BIN" verify -v "$APK_SIGNED"
    echo "✅ APK aligned and signed: $APK_SIGNED"
fi

echo "🎉 Build complete!"