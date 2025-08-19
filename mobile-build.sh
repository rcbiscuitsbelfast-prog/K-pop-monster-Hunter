#!/bin/bash

# Mobile Build Script for Unlucky
# Optimized for Termux and mobile development environments
# Part of the MIFF (Make It For Free) movement

set -euo pipefail

echo "📱 Mobile Build Script for Unlucky"
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

# Check Android SDK
if [ -n "${ANDROID_HOME:-}" ] || [ -d "$HOME/Android/Sdk" ]; then
    echo "✅ Android SDK found"
else
    echo "⚠️  Android SDK not found. This is okay for building APKs."
    echo "   The APK can be transferred to a device with Android Studio for installation."
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
    
    # Display APK info if aapt is available
    if command -v aapt >/dev/null 2>&1; then
        echo "🔍 APK details:"
        aapt dump badging "$APK_PATH" | grep -E "(package|application-label|version)" || true
    fi
    
    echo ""
    echo "🎉 Mobile build complete!"
    echo ""
    echo "📋 Next steps:"
    echo "   1. Transfer APK to your Android device"
    echo "   2. Enable 'Install from unknown sources'"
    echo "   3. Install and test the game"
    echo ""
    echo "📤 Transfer options:"
    echo "   - Use 'adb push' if connected via USB"
    echo "   - Upload to cloud storage (Google Drive, etc.)"
    echo "   - Use file sharing apps"
    echo ""
    echo "🔧 Build info:"
    echo "   - Keystore: android/keystore/open-remix.keystore"
    echo "   - Alias: remixkey"
    echo "   - Password: remixpass"
    echo "   - Target: Android 8.0+ (API 26+)"
    
    # Create a simple transfer script
    cat > transfer-apk.sh << 'EOF'
#!/bin/bash
echo "📤 APK Transfer Helper"
echo "APK location: android/build/outputs/apk/release/android-release.apk"
echo ""
echo "Options:"
echo "1. Copy to Downloads (if available)"
echo "2. Show file info"
echo "3. Exit"
read -p "Choose option (1-3): " choice

case $choice in
    1)
        if [ -d "$HOME/Download" ]; then
            cp android/build/outputs/apk/release/android-release.apk "$HOME/Download/"
            echo "✅ APK copied to Downloads folder"
        elif [ -d "/sdcard/Download" ]; then
            cp android/build/outputs/apk/release/android-release.apk "/sdcard/Download/"
            echo "✅ APK copied to Downloads folder"
        else
            echo "❌ Downloads folder not found"
        fi
        ;;
    2)
        ls -la android/build/outputs/apk/release/android-release.apk
        ;;
    3)
        echo "Goodbye!"
        ;;
    *)
        echo "Invalid option"
        ;;
esac
EOF
    chmod +x transfer-apk.sh
    echo "📤 Transfer helper created: ./transfer-apk.sh"
    
else
    echo "❌ APK build failed!"
    echo "🔍 Check the build logs above for errors"
    exit 1
fi

echo ""
echo "🎵 Happy remixing! Part of the MIFF movement."