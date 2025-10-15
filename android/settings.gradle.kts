pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()   // مهم جداً لبلجن flutter-plugin-loader
    }
    includeBuild("../.dart_tool/flutter_build")
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
}

include(":app")
