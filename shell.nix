let
  pkgs = import <nixpkgs> {
    config.android_sdk.accept_license = true;
    config.allowUnfree = true;
  };

  androidSDK = (pkgs.androidenv.composeAndroidPackages {
    platformVersions = [ "28" ];
    abiVersions = [ "x86" "x86_64" ];
    ndkVersion = "21.1.6210238-rc1";
    includeNDK = true;
  }).androidsdk;
in
pkgs.mkShell {
  name = "vlc-android";
  buildInputs = with pkgs; [
    androidSDK
    ant
    autoconf
    automake
    bison
    flex
    gettext
    gradle
    help2man
    libtool
    meson
    nasm
    ninja
    openjdk
    pkgconfig
    protobuf3_12
    ragel
    wget
  ];

  ANDROID_SDK = androidSDK;
  ANDROID_NDK = "${androidSDK}/libexec/android-sdk/ndk-bundle";
  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidSDK}/libexec/android-sdk/build-tools/28.0.3/aapt2";
}
