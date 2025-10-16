
#!/usr/bin/env bash
set -euo pipefail
sed -i 's/minSdk [0-9]\+/minSdk 24/g' android/app/build.gradle || true
grep -q 'multidex' android/app/build.gradle ||   sed -i '/dependencies {/a \ \ \ \ implementation "androidx.multidex:multidex:2.0.1"' android/app/build.gradle
echo "[AutoFix] Gradle tweaks done."
