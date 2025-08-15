# 🎮 K-pop Monster Hunter Remix - Remix Guide

## 🎵 Welcome to the MIFF Movement!

**Make It For Free** - Empowering creators to build, share, and remix games without barriers. This project demonstrates how to create a fully open-source game with automatic CI/CD, public keystores, and zero secrets.

## 🚀 Quick Start

### Prerequisites
- **Android Studio** or **Android SDK** (API 26+, Android 8.0+)
- **Java 17** (OpenJDK/Temurin recommended)
- **Git** for version control

### One-Command Build
```bash
# Clone the repository
git clone https://github.com/your-username/kpop-monster-hunter-remix.git
cd kpop-monster-hunter-remix

# Build APK (automatically signed with public keystore)
./build-apk.sh

# Or use Gradle directly
./gradlew :android:assembleRelease
```

The APK will be automatically signed and ready to install on Android 8.0+ devices!

## 🔧 Build System Details

### Public Keystore Configuration
- **Location**: `android/keystore/open-remix.keystore`
- **Alias**: `remixkey`
- **Password**: `remixpass`
- **No secrets required** - everything is committed to the repository

### Gradle Configuration
```gradle
// android/build.gradle
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
        signingConfig signingConfigs.remix
    }
    debug {
        signingConfig signingConfigs.remix
    }
}
```

### Build Commands
```bash
# Debug build (faster, larger APK)
./gradlew :android:assembleDebug

# Release build (optimized, smaller APK)
./gradlew :android:assembleRelease

# Clean build
./gradlew clean

# Run on connected device
./gradlew :android:installDebug
```

## 🤖 CI/CD Pipeline

### GitHub Actions Workflow
The project includes automatic builds on every push to:
- `core/` (gameplay logic)
- `android/` (Android-specific code)
- `desktop/` (desktop version)
- Build configuration files

### Workflow Features
- ✅ **Automatic APK building** on code changes
- ✅ **Public keystore signing** (no secrets needed)
- ✅ **Artifact upload** for easy download
- ✅ **GitHub Releases** for main branch builds
- ✅ **Build verification** and APK info display
- ✅ **Mobile-friendly** workflow summaries

### Manual Trigger
You can manually trigger builds in GitHub Actions with:
- **Build type**: debug or release
- **Branch**: main or develop

## 📱 Mobile Development

### Termux Setup (Android)
```bash
# Install Termux from F-Droid
# Update packages
pkg update && pkg upgrade

# Install required packages
pkg install openjdk-17 gradle git

# Clone and build
git clone https://github.com/your-username/kpop-monster-hunter-remix.git
cd kpop-monster-hunter-remix
./gradlew :android:assembleRelease
```

### Local Installation
1. **Download APK** from GitHub Actions artifacts
2. **Enable "Install from unknown sources"** in Android settings
3. **Install APK** on your device
4. **Test gameplay** and provide feedback

## 🎵 Game Architecture

### Modular Design
- **Core**: Platform-agnostic game logic
- **Android**: Android-specific implementation
- **Desktop**: Desktop version for development
- **Assets**: Shared game resources

### Key Components
- **Rhythm Engine**: Beat detection and timing
- **Combat System**: Monster hunting mechanics
- **Audio System**: K-pop music integration
- **UI Framework**: Responsive mobile interface

## 🎨 Asset Guidelines

### Ethical Asset Sourcing
This project follows MIFF principles for ethical asset creation:

#### ✅ Recommended Sources
- **Creative Commons** licensed assets
- **Public domain** materials
- **Original creations** by contributors
- **Open source** game assets
- **Royalty-free** music and sound effects

#### ❌ Avoid
- **Copyrighted** K-pop music without permission
- **Proprietary** assets or engines
- **Non-commercial** only licenses
- **Attribution-required** assets without proper credit

#### 🎵 Music Guidelines
- Use **original compositions** inspired by K-pop
- **Public domain** classical music remixes
- **Creative Commons** licensed tracks
- **Royalty-free** background music
- **User-generated** content (with permission)

### Asset Structure
```
assets/
├── audio/
│   ├── music/          # Background tracks
│   ├── sfx/           # Sound effects
│   └── voice/         # Voice clips
├── graphics/
│   ├── characters/    # Player and NPC sprites
│   ├── monsters/      # Enemy designs
│   ├── ui/           # Interface elements
│   └── backgrounds/   # Level backgrounds
└── data/
    ├── levels/        # Level definitions
    └── config/        # Game configuration
```

## 🔄 Remixing Guidelines

### Fork and Remix
1. **Fork** the repository on GitHub
2. **Clone** your fork locally
3. **Create** a new branch for your remix
4. **Modify** gameplay, assets, or mechanics
5. **Test** thoroughly on mobile devices
6. **Push** changes to trigger automatic builds
7. **Share** your remix with the community

### Remix Ideas
- **New K-pop genres** (J-pop, C-pop, etc.)
- **Different monster types** and behaviors
- **Alternative rhythm mechanics**
- **Visual style variations**
- **Multiplayer features**
- **Story mode expansions**

### Contribution Guidelines
- **MIT License** - all contributions must be MIT licensed
- **No secrets** - everything must be public and remixable
- **Mobile-first** - prioritize Android compatibility
- **Documentation** - explain your changes clearly
- **Testing** - ensure builds work on real devices

## 🛠️ Development Tools

### Recommended IDEs
- **Android Studio** - Full Android development
- **IntelliJ IDEA** - Java development
- **VS Code** - Lightweight editing
- **Termux** - Mobile development

### Debugging
```bash
# View build logs
./gradlew :android:assembleDebug --info

# Check APK contents
aapt dump badging android/build/outputs/apk/debug/android-debug.apk

# Install and run on device
./gradlew :android:installDebug
adb shell am start -n com.miff.kpopmonsterhunter/.AndroidLauncher
```

## 📚 Resources

### MIFF Movement
- **Website**: [Make It For Free](https://makeitforfree.org)
- **Principles**: Open source, no barriers, community-driven
- **Tools**: Public keystores, automatic builds, shared assets

### Game Development
- **LibGDX**: [Official Documentation](https://libgdx.com/wiki/)
- **Android Development**: [Android Developer Guide](https://developer.android.com/)
- **Gradle**: [Build System Documentation](https://gradle.org/docs/)

### Asset Creation
- **Aseprite**: Pixel art and sprite creation
- **Audacity**: Audio editing and processing
- **Blender**: 3D modeling (for 2D sprites)
- **GIMP**: Image editing and manipulation

## 🤝 Community

### Get Involved
- **Discord**: Join our development community
- **GitHub Issues**: Report bugs and request features
- **Pull Requests**: Contribute code and assets
- **Discussions**: Share ideas and remixes

### Code of Conduct
- **Respectful** communication
- **Inclusive** environment
- **Constructive** feedback
- **Open** to all skill levels

## 📄 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

All assets and code are free to use, modify, and distribute according to the MIT License terms.

---

**🎵 Let's make amazing games together, for free! 🎵**

*Part of the MIFF (Make It For Free) movement - empowering creators worldwide.*