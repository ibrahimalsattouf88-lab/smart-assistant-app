// android/app/build.gradle.kts  (SMART-ASSISTANT-APP)

plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "com.example.smart_assistant_app"
    compileSdk = flutter.compileSdkVersion

    defaultConfig {
        applicationId = "com.example.smart_assistant_app"
        minSdk = maxOf(21, flutter.minSdkVersion) // يضمن 21 على الأقل
        targetSdk = flutter.targetSdkVersion
        versionCode = 1
        versionName = "1.0.0"
        multiDexEnabled = true
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("debug")
        }
        getByName("debug") {
            isDebuggable = true
        }
    }

    // Java 17
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    // استخدم JDK 17 لبناء Kotlin
    kotlin {
        jvmToolchain(17)
    }

    packaging {
        resources {
            excludes += setOf(
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE",
                "META-INF/LICENSE.txt",
                "META-INF/NOTICE",
                "META-INF/NOTICE.txt"
            )
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk8")
}
