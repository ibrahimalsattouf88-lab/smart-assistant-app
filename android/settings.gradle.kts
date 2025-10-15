pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
    plugins {
        id("com.android.application") version "8.9.1"
        id("com.android.library") version "8.9.1"
        id("org.jetbrains.kotlin.android") version "1.9.24"
        id("dev.flutter.flutter-plugin-loader") version "1.0.0"
    }
}

dependencyResolutionManagement {
    repositoriesMode.set(RepositoriesMode.FAIL_ON_PROJECT_REPOS)
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.name = "smart_assistant_app"
include(":app")
