import 'dart:ui';

import 'package:flutter/material.dart';

import 'responsive.dart';

extension MxContextExtensions on BuildContext {
  MxResponsiveUiData get _mxResponsive => MxResponsiveUiData.of(this);

  /// Screen Sizes Extensions for responsive UI

  /// Returns Material no. of Columns as per Material Design Guidelines.
  int get mxColumns => _mxResponsive.columns;

  /// Returns Material no. of Gutters as per Material Design Guidelines.
  double get mxGutter => _mxResponsive.gutter;

  /// Returns device Type  as per Material Design Guidelines.
  MxMobileDeviceType get mxDeviceType => _mxResponsive.deviceInfo.deviceType;

  /// Returns device size as per Material Design Guidelines.
  MxDeviceSize get mxDeviceSize => _mxResponsive.deviceInfo.deviceSize;

  /// Returns the current window size as per Material Design Guidelines.
  MxWindowSize get mxWindowSize => _mxResponsive.windowSize;

  /// Check if the window size is of Mobile Type as per Material Design Guidelines.
  bool get isMobileSize => mxWindowSize == MxWindowSize.xsmall;

  /// Returns if it's a handset as per Material Design Guidelines.
  bool get isMobileTypeHandset => mxDeviceType == MxMobileDeviceType.handset;

  /// Returns if it's a tablet as per Material Design Guidelines.
  bool get isMobileTypeTablet => mxDeviceType == MxMobileDeviceType.tablet;

  /// To get a [MediaQuery] directly.
  MediaQueryData get mq => MediaQuery.of(this);

  /// Get MediaQuery Screen Size
  Size get screenSize => mq.size;

  /// Get MediaQuery devicePixelRatio
  double get devicePixelRatio => mq.devicePixelRatio;

  /// Get MediaQuery Screen Padding
  EdgeInsets get screenPadding => mq.padding;

  /// Get MediaQuery Screen Width
  double get screenWidth => mq.size.width;

  /// Get MediaQuery Screen Height
  double get screenHeight => mq.size.height;

  /// Get MediaQuery Screen Width in percentage
  double get widthInPercent => screenWidth / 100;

  /// Get MediaQuery Screen height in percentage
  double get heightInPercent => screenHeight / 100;

  /// Get MediaQuery safearea padding horizontally
  double get safeAreaHorizontal => mq.padding.left + mq.padding.right;

  /// Get MediaQuery safearea padding vertically
  double get safeAreaVertical => mq.padding.top + mq.padding.bottom;

  /// Get MediaQuery Screen Width in percentage including safe area calculation.
  double get safeAreaWidthInPercent => (screenWidth - safeAreaHorizontal) / 100;

  /// Get MediaQuery Screen Height in percentage including safe area calculation.
  double get safeAreaHeightInPercent => (screenHeight - safeAreaVertical) / 100;

  /// Gives you the power to get a portion of the height.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the height
  ///
  /// [reducedBy] is a percentage value of how much of the height you want
  /// if you for example want 46% of the height, then you reduce it by 54%.
  double heightTransformer({double dividedBy = 1, double reducedBy = 0.0}) =>
      (screenSize.height - ((screenSize.height / 100) * reducedBy)) / dividedBy;

  /// Gives you the power to get a portion of the width.
  /// Useful for responsive applications.
  ///
  /// [dividedBy] is for when you want to have a portion of the value you
  /// would get like for example: if you want a value that represents a third
  /// of the screen you can set it to 3, and you will get a third of the width
  ///
  /// [reducedBy] is a percentage value of how much of the width you want
  /// if you for example want 46% of the width, then you reduce it by 54%.
  double widthTransformer({double dividedBy = 1, double reducedBy = 0.0}) =>
      (screenSize.width - ((screenSize.width / 100) * reducedBy)) / dividedBy;

  /// Divide the height proportionally by the given value
  double ratio(
          {double dividedBy = 1,
          double reducedByW = 0.0,
          double reducedByH = 0.0}) =>
      heightTransformer(dividedBy: dividedBy, reducedBy: reducedByH) /
      widthTransformer(dividedBy: dividedBy, reducedBy: reducedByW);

  /// Returns the [FlutterView] that the provided `context` will render into.
  FlutterView get view => View.of(this);

  /// Returns the [FlutterView] that the provided `context` will render into.
  FlutterView? get maybeView => View.maybeOf(this);

  ///Returns Orientation using [MediaQuery]
  Orientation get orientation => mq.orientation;

  /// Returns if Orientation is landscape
  bool get isLandscape => orientation == Orientation.landscape;

  /// True if width be larger than 800
  bool get canShowNavRail => screenWidth > 800;
}
