
# Unlucky 
Unlucky is a LibGDX Android RPG game based on RNG (random number generator) with a turn-based battle system. RNG is usually frowned upon in games, but this game's entire theme is RNG. Everything from attacks in battle to item enchanting to movement is based on RNG. 
<div>
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/44676899-856d7600-aa02-11e8-82ca-897e3ca45092.gif">
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/44678123-9e2b5b00-aa05-11e8-93ab-d9d0c693ddfa.gif">
</div>

## About

The player ventures and battles monsters in maps with various themes. Currently there are three available worlds all with 10+ levels in each world. In these maps, the player will have to defeat monsters and find a star tile to complete the level. Monsters may drop items that can improve the player's strength. These items may be sold in the shop for gold or enchanted to increase their power. There are currently 100+ items dropped by monsters and sold in the shop.

The battle system is based on turn-based mechanics. The player is given four randomly generated moves with each color corresponding to a different type of move. The player also has access to special moves that they can choose in the menu. Special moves give bonus effects to the player's attacks or affects the enemy. The player also has an option to run from the battle at a very low chance of success.

## Downloads
Releases for Desktop are found on the [releases page](https://github.com/mingli1/Unlucky/releases). It is in a runnable .jar format so you must have JRE installed. 

Note: running the game on desktop will create a `save.json` file in the same directory as the game. The game must be run in the same directory as the save.json to work and load your progress.

Also available for free on the [Google Play Store](https://play.google.com/store/apps/details?id=com.unlucky.main)

### Building Android APK
This project includes a comprehensive GitHub Actions workflow that automatically builds and releases Android APK files. The build system has been modernized and optimized for reliability.

**To trigger a build:**
1. **Automatic Release**: Push a tag starting with 'v' (e.g., `v1.0.0`) to trigger an automatic build and release
2. **Manual Build**: Go to the Actions tab in GitHub and manually trigger the "Build Android APK" workflow

**The workflow will:**
- Set up Java 17 and Android SDK with build tools 30.0.3
- Build a signed APK file using modern Android build tools
- Create a GitHub release with the APK as a downloadable asset
- Upload the APK as a build artifact for debugging

**To build locally:**
```bash
# Make sure you have Java 17+ and Android SDK installed
./gradlew android:assembleRelease

# Or use the provided build script
./build-apk.sh
```

**Build System Requirements:**
- Java 17 or higher
- Android SDK with build tools 29.0.3
- Gradle 8.5+

## Build System Improvements

This project has been modernized with the following technical improvements:

### **Updated Build Infrastructure**
- **Java Compatibility**: Upgraded from Java 8 to Java 17 for better performance and modern Android SDK support
- **Gradle Version**: Updated to Gradle 8.3 with enhanced caching and build performance
- **Android Gradle Plugin**: Upgraded to 8.1.4 for modern Android development features
- **Build Tools**: Using reliable build tools 29.0.3 with full `aapt` and `aapt2` support

### **GitHub Actions Workflow**
- **Automated CI/CD**: Complete automated build and release pipeline
- **Java 17 Setup**: Proper Java 17 configuration with Temurin distribution
- **Android SDK Management**: Automated Android SDK setup with specific build tools
- **APK Signing**: Automated APK signing with debug keystore
- **Release Management**: Automatic GitHub releases with downloadable APKs

### **Local Development**
- **Build Script**: Added `build-apk.sh` for easy local APK building
- **Gradle Wrapper**: Complete Gradle wrapper setup for consistent builds
- **Dependency Management**: Updated to modern dependency configurations

### **Technical Specifications**
- **Minimum SDK**: Android API 21 (Android 5.0)
- **Target SDK**: Android API 30 (Android 11)
- **Compile SDK**: Android API 30
- **Build Tools**: 29.0.3
- **Java Version**: 17
- **Gradle Version**: 8.5

The assets for this game are also available for download:
* [Textures](https://github.com/mingli1/Unlucky/files/2300518/textures.zip) (contains a file `textures.png` that has all the textures in the game mapped into an atlas `textures.atlas`)
* [Skins](https://github.com/mingli1/Unlucky/files/2300523/skins.zip) (contains LibGDX Skins of the game)
* [Music](https://github.com/mingli1/Unlucky/files/2300525/music.zip) (all music in the game in `.ogg` format)
* [Sound Effects](https://github.com/mingli1/Unlucky/files/2300530/sfx.zip) (all sfx in the game mostly in `.ogg` format)

## Credits
* **Programming** - done by me using Java 17 and the [LibGDX library](https://libgdx.badlogicgames.com/)
* **Artwork** - done by me using [Paint.net](https://www.getpaint.net/) and textures packed using [Gdx Texture Packer GUI](https://github.com/crashinvaders/gdx-texture-packer-gui)
* **Music** - done by me using [Bosca Cecilo](https://boscaceoil.net/)
* **Sound Effects** - all sound effects are under [CC0](https://creativecommons.org/share-your-work/public-domain/cc0/) from [Freesound](https://freesound.org/) and edited by me using [Audacity](https://www.audacityteam.org/)

## Development

### **Build System Modernization**
The build system has been completely modernized to support:
- Modern Java development (Java 17+)
- Current Android development standards
- Automated CI/CD with GitHub Actions
- Reliable APK building and distribution

### **Technology Stack**
- **Game Engine**: LibGDX 1.9.4
- **Language**: Java 17
- **Build System**: Gradle 8.5
- **Android Build**: Android Gradle Plugin 8.1.4
- **CI/CD**: GitHub Actions
- **APK Distribution**: GitHub Releases

## Troubleshooting

### **Common Build Issues**

**Java Version Issues:**
```bash
# Ensure you have Java 17+ installed
java -version

# Set JAVA_HOME if needed
export JAVA_HOME=/path/to/java17
```

**Android SDK Issues:**
```bash
# Ensure Android SDK is installed and ANDROID_HOME is set
echo $ANDROID_HOME

# Install required build tools
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;29.0.3"
```

**Gradle Issues:**
```bash
# Clean and rebuild
./gradlew clean
./gradlew android:assembleRelease

# Check Gradle version
./gradlew --version
```

**APK Signing Issues:**
```bash
# Use the provided build script for local signing
./build-apk.sh --sign
```

### **GitHub Actions Issues**
- Check the Actions tab for detailed build logs
- Ensure the workflow has proper permissions
- Verify that tags are properly formatted (e.g., `v1.0.0`)

## License
This project is licensed under the [MIT License](https://github.com/mingli1/Unlucky/blob/master/LICENSE).

## Screenshots
<div>
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42198355-8515a9ee-7e55-11e8-9c5a-9b85f8211ac4.PNG">
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42197174-8c740a06-7e4f-11e8-9280-21c1850ceb48.PNG">
</div>
<div>
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42197176-912aed08-7e4f-11e8-8754-b4889dfb540f.PNG">
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42197178-932f6f20-7e4f-11e8-9c49-6e4108ee0c26.PNG">
</div>
<div>
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42197185-97c8b802-7e4f-11e8-879d-605d42c9260e.PNG">
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42197189-9b425a06-7e4f-11e8-8e76-d7c3de9c2a28.PNG">
</div>
<div>
    <img width="400px" height="240px" hspace="15" src="https://user-images.githubusercontent.com/29984767/42197192-9db252c8-7e4f-11e8-80c5-4812fa018eae.PNG">
</div>
