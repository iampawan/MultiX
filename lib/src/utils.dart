import 'package:flutter/foundation.dart';
import 'package:multi_x/src/nav/i_mx_nav.dart';

class Mx {
  ///Checks whether release mode or not
  static bool get isReleaseMode => kReleaseMode;

  ///Checks whether debug mode or not
  static bool get isDebugMode => kDebugMode;

  ///Checks whether profile mode or not
  static bool get isProfileMode => kProfileMode;

  ///Checks whether web or not
  static bool get isWeb => kIsWeb;

  ///Checks whether the device is android or not
  static bool get isAndroid =>
      !isWeb && defaultTargetPlatform == TargetPlatform.android;

  ///Checks whether the device is iOS or not
  static bool get isIOS =>
      !isWeb && defaultTargetPlatform == TargetPlatform.iOS;

  ///Checks whether the device is a mobile OS or not
  static bool get isMobileOS => !isWeb && (isAndroid || isIOS);

  ///Checks whether the device is linux or not
  static bool get isLinux =>
      !isWeb && defaultTargetPlatform == TargetPlatform.linux;

  ///Checks whether the device is macOS or not
  static bool get isMacOS =>
      !isWeb && defaultTargetPlatform == TargetPlatform.macOS;

  ///Checks whether the device is windows or not
  static bool get isWindows =>
      !isWeb && defaultTargetPlatform == TargetPlatform.windows;

  ///Checks whether the device is fuchsia or not
  static bool get isFuchsia =>
      !isWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  ///Checks whether desktop or not
  static bool get isDesktop =>
      !isWeb &&
      (defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows);

  /// Uses [PathUrlStrategy] on the web, which removes hashes from URLs. This
  /// must be called at app startup, before `runApp` is called.
  ///
  /// Calling this method does nothing when not running on the web.
  static void setPathUrlStrategy() {
    if (kIsWeb) {
      MxNav.setPathUrlStrategy(); // coverage:ignore-line
    }
  }

  static void setHashUrlStrategy() {
    if (kIsWeb) {
      MxNav.setHashUrlStrategy(); // coverage:ignore-line
    }
  }
}
