#!/bin/bash

# Build APK script for Unlucky game
# This script helps build the Android APK locally

echo "Building Unlucky Android APK..."

# Make gradlew executable
chmod +x gradlew

# Clean previous builds
echo "Cleaning previous builds..."
./gradlew clean

# Build release APK
echo "Building release APK..."
./gradlew android:assembleRelease

# Check if build was successful
if [ -f "android/build/outputs/apk/release/android-release-unsigned.apk" ]; then
    echo "✅ APK built successfully!"
    echo "📱 APK location: android/build/outputs/apk/release/android-release-unsigned.apk"
    echo "📏 APK size: $(du -h android/build/outputs/apk/release/android-release-unsigned.apk | cut -f1)"
    
    # Optional: Sign the APK if you have a keystore
    if [ "$1" = "--sign" ]; then
        echo "🔐 Signing APK..."
        if [ -f "keystore.jks" ]; then
            jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore keystore.jks android/build/outputs/apk/release/android-release-unsigned.apk android
            echo "✅ APK signed successfully!"
        else
            echo "⚠️  No keystore found. Creating debug keystore..."
            keytool -genkey -v -keystore keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias android -storepass android -keypass android -dname "CN=Android Debug,O=Android,C=US"
            jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore keystore.jks android/build/outputs/apk/release/android-release-unsigned.apk android
            echo "✅ APK signed with debug keystore!"
        fi
    fi
else
    echo "❌ APK build failed!"
    exit 1
fi

echo "🎉 Build complete!"