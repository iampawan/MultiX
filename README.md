# multi_x

[![Pub](https://img.shields.io/pub/v/multi_x.svg?style=flat-square)](https://pub.dartlang.org/packages/multi_x)

Provide an easy way to make responsive and adaptive Flutter multi-platform applications.

## Getting started

### Add dependency

```yaml
dependencies:
  multi_x: any
```

## Features

This packages offers - 

### Widgets

1. MxAdaptive - A widget that enables screen adaptation and scaling in Flutter applications.

1. MxAdaptiveNavigation - MxAdaptiveNavigation is a wigdet which can be used for navigation throughout the app. On Small screen it use NavigationBar and on Large screen it use NavigationRail.

1. MxResponsive - A widget that shows a child widget based on the screen size.

1. MxDevice - A widget that shows a child widget based on the device window size either mobile or not.

1. MxLayout - MxLayout is a type of [LayoutBuilder] with some additional power

1. MxPlatform - A widget that shows a child widget based on the platform either Android or iOS or Desktop or Web.

1. MxConditional - A widget that shows a child widget if a condition is true, otherwise shows another child widget.

1. MxConditionalSwitch - A widget that shows a child widget based on switch case conditions.

### Extensions

1. mxColumns - Returns Material no. of Columns as per Material Design Guidelines.

1. mxGutter - Returns Material no. of Gutter as per Material Design Guidelines.

1. mxDeviceType - Returns DeviceType as per Device Screen Size.

1. mxDeviceSize - Returns DeviceSize as per Device Screen Size.

1. mxWindowSize - Returns current window size as per material design breakpoints.

1. isMobileSize - Returns true if window size is of mobile.

1. mq - Returns MediaQuery.of(context).

1. screensize - Returns MediaQuery.of(context).size.

1. devicePixelRatio - Returns MediaQuery.of(context).devicePixelRatio.

1. screenPadding - Returns MediaQuery.of(context).padding.

1. screenWidth - Returns MediaQuery.of(context).size.width.

1. screenHeight - Returns MediaQuery.of(context).size.height.

1. widthInPercent - Returns MQ width in percent.

1. heightInPercent - Returns MQ height in percent.

1. safeAreaHorizontal - Returns safe area horizontal padding.

1. safeAreaVertical - Returns safe area vertical padding.

1. safeAreaWidthInPercent - Returns safe area width in percent.

1. safeAreaHeightInPercent - Returns safe area height in percent.

1. heightTransformer() - Gives you the power to get a portion of the height.

1. widthTransformer() - Gives you the power to get a portion of the width.

1. ratio() - Divide the height/width proportionally by the given value.

1. view - Returns the [FlutterView] that the provided `context` will render into.

1. maybeView - Returns the [FlutterView] that the provided `context` will render into.

1. orientation - Returns the orientation of the device using MediaQuery.

1. isLandscape - Returns true if orientation is landscape.

1. canShowNavigationRail - Returns true if orientation is landscape and width is greater than 800.


### Utils

1. Mx.isReleaseMode - Returns true if app is running in release mode.

1. Mx.isDebugMode - Returns true if app is running in debug mode.

1. Mx.isProfileMode - Returns true if app is running in profile mode.

1. Mx.isWeb - Returns true if app is running on web.

1. Mx.isDesktop - Returns true if app is running on desktop.

1. Mx.isMobileOS - Returns true if app is running on mobile.

1. Mx.isAndroid - Returns true if app is running on Android.

1. Mx.isIOS - Returns true if app is running on iOS.

1. Mx.isMacOS - Returns true if app is running on macOS.

1. Mx.isWindows - Returns true if app is running on Windows.

1. Mx.isLinux - Returns true if app is running on Linux.

1. Mx.isFuchsia - Returns true if app is running on Fuchsia.

1. Mx.setPathUrlStrategy() - Sets the path url strategy for web.

1. Mx.setHashUrlStrategy() - Sets the hash url strategy for web.






