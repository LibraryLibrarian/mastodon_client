/// Constants for detecting the build mode in a Dart environment.
library;

/// Whether the application is running in release mode.
const bool kReleaseMode = bool.fromEnvironment('dart.vm.product');

/// Whether the application is running in debug mode.
const bool kDebugMode = !kReleaseMode;
