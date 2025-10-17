<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.smartassistant">  <!-- عدّل للباكيج الصحيح في لوحة التحكم -->

    <application
        android:label="Smart Assistant"     <!-- عدّل الاسم للتطبيق الآخر -->
        android:icon="@mipmap/ic_launcher">
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:windowSoftInputMode="adjustResize">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>

            <meta-data
                android:name="io.flutter.embedding.android.NormalTheme"
                android:resource="@style/NormalTheme" />
        </activity>

        <!-- إشارة صريحة لاستخدام v2 -->
        <meta-data
            android:name="flutterEmbedding"
            android:value="2"/>
    </application>
</manifest>
