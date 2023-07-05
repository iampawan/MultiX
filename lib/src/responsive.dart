import 'dart:math';

import 'package:flutter/material.dart';

/// A class that can be queried for breakpoints based on the guidelines in
/// https://material.io/guidelines/layout/responsive-ui.html .
class MxResponsiveUiData {
  static MxResponsiveUiData of(BuildContext context) =>
      MxResponsiveUiData._(MediaQuery.of(context));

  final MediaQueryData _data;

  MxResponsiveUiData._(this._data);

  /// Returns the [MxDeviceInfo] (type and symbolic size) for the device.
  MxDeviceInfo get deviceInfo => MxDeviceInfo(_data);

  /// Returns the symbolic window size of the device.
  MxWindowSize get windowSize {
    if (_width < 600.0) {
      return MxWindowSize.xsmall;
    }

    if (_width < 1024.0) {
      return MxWindowSize.small;
    }
    if (_width < 1440.0) {
      return MxWindowSize.medium;
    }

    if (_width < 1920.0) {
      return MxWindowSize.large;
    }

    return MxWindowSize.xlarge;
  }

  /// Returns the recommended number of grid layout columns.
  int get columns {
    if (_width < 600.0) {
      return 4;
    }

    if (_width < 840.0) {
      return 8;
    }

    return 12;
  }

  /// Returns the recommended gutter width, in logical pixels.
  double get gutter {
    if (_minDimension < 600.0) {
      return _width < 960.0 ? 16.0 : 24.0;
    } else {
      return _width < 600.0 ? 16.0 : 24.0;
    }
  }

  double get _width => _data.size.width;

  double get _minDimension => min(_width, _data.size.height);
}

/// Types of mobile devices.
///
/// Note that this is based exclusively on the dimensions of the device and
/// not on the presence of a phone.
enum MxMobileDeviceType { handset, tablet }

/// Symbolic sizes of mobile devices.
///
/// Note that the ranges are different depending on the [MxMobileDeviceType] of
/// the device. Note also that only handsets can be [medium].
enum MxDeviceSize { small, medium, large }

/// Combines [MxMobileDeviceType] and [MxDeviceSize].
abstract class MxDeviceInfo {
  final double _width;

  factory MxDeviceInfo(MediaQueryData data) =>
      data.orientation == Orientation.portrait
          ? _MxPortraitDeviceInfo(data.size.width)
          : _MxLandscapeDeviceInfo(data.size.width);

  MxDeviceInfo._(this._width);

  /// Determines whether the device is a handset or tablet.
  ///
  /// Note that for some devices the device type may change depending
  /// on its orientation.
  MxMobileDeviceType get deviceType;

  /// Determines the symbolic size of a device.
  ///
  /// Note that for some devices the device size may change depending
  /// on its orientation.
  MxDeviceSize get deviceSize;
}

class _MxPortraitDeviceInfo extends MxDeviceInfo {
  _MxPortraitDeviceInfo(super.width) : super._();

  @override
  MxMobileDeviceType get deviceType =>
      _width < 600.0 ? MxMobileDeviceType.handset : MxMobileDeviceType.tablet;

  @override
  MxDeviceSize get deviceSize {
    // handsets
    if (_width < 360.0) {
      return MxDeviceSize.small;
    }

    if (_width < 400.0) {
      return MxDeviceSize.medium;
    }

    if (_width < 600.0) {
      return MxDeviceSize.large;
    }
    // tablets
    if (_width < 720.0) {
      return MxDeviceSize.small;
    }

    return MxDeviceSize.large;
  }
}

class _MxLandscapeDeviceInfo extends MxDeviceInfo {
  _MxLandscapeDeviceInfo(super.width) : super._();

  @override
  MxMobileDeviceType get deviceType =>
      _width < 960.0 ? MxMobileDeviceType.handset : MxMobileDeviceType.tablet;

  @override
  MxDeviceSize get deviceSize {
    // handsets
    if (_width < 600.0) {
      return MxDeviceSize.small;
    }

    if (_width < 720.0) {
      return MxDeviceSize.medium;
    }

    if (_width < 960.0) {
      return MxDeviceSize.large;
    }
    // tablets
    if (_width < 1024.0) {
      return MxDeviceSize.small;
    }

    return MxDeviceSize.large;
  }
}

/// Symbolic window sizes of mobile devices.
enum MxWindowSize { xsmall, small, medium, large, xlarge }
