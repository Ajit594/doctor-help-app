# Keep Flutter classes used by reflection or native hosts
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }

# Keep classes used by FCM and Firebase libraries if present
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep generated JSON model classes if you use reflection-based libraries
# (Uncomment if needed)
#-keepclassmembers class * {
#    @com.fasterxml.jackson.annotation.* <fields>;
#}

# If you use serialization libraries like Gson, keep their annotations
-keepattributes Signature
-keepattributes *Annotation*

# Keep native method names
-keepclasseswithmembernames class * {
    native <methods>;
}

# Suppress warnings for Play Core / SplitInstall classes referenced by Flutter's
# embedding when deferred components are not present in the project.
-dontwarn com.google.android.play.core.**
-dontwarn com.google.android.play.core.splitcompat.**
-dontwarn com.google.android.play.core.splitinstall.**
-dontwarn com.google.android.play.core.tasks.**

# Keep the Flutter PlayStore split application wrapper referenced by embedding.
-keep class io.flutter.embedding.android.FlutterPlayStoreSplitApplication { *; }
