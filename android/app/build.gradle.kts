
plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
}
android {
    namespace = "com.ibrahim.smart_assistant_app"
    compileSdk = 35
    defaultConfig {
        applicationId = "com.ibrahim.smart_assistant_app"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"
    }
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
        debug { initWith(getByName("release")); isMinifyEnabled = false }
    }
}
dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.0.20")
}
